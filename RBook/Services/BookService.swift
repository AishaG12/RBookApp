//
//  BookService.swift
//  RBookApp
//
//  Created by Aisha Hudasi on 26/06/1447 AH.
//
import Foundation

// MARK: - Errors
enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int, body: String?)
    case decodingError(Error)
    case emptyData
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .invalidResponse: return "Invalid response from server."
        case .httpError(let code, _): return "HTTP Error: \(code)"
        case .decodingError(let err): return "Failed to decode response: \(err.localizedDescription)"
        case .emptyData: return "Empty response data."
        case .unknown(let err): return "Unknown error: \(err.localizedDescription)"
        }
    }
}


// MARK: - Service
final class BookService {

    private let debugLog = true

    
    func searchBooks(query: String, limit: Int = 20) async throws -> [Book] {
        let q = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query

        async let gut = searchGutendex(q: q, limit: limit)
        async let ol  = searchOpenLibrary(q: q, limit: limit)

        let (gutBooks, olBooks) = await (try gut, try ol)

        
        var mixed: [Book] = []
        mixed.reserveCapacity(limit)

       
        var seen = Set<String>()
        func key(_ b: Book) -> String {
            "\(b.title.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))|\(b.author.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))"
        }

        for b in gutBooks {
            let k = key(b)
            if !seen.contains(k) {
                seen.insert(k)
                mixed.append(b)
                if mixed.count == limit { return mixed }
            }
        }

        for b in olBooks {
            let k = key(b)
            if !seen.contains(k) {
                seen.insert(k)
                mixed.append(b)
                if mixed.count == limit { return mixed }
            }
        }

        return mixed
    }

    // MARK: - Gutendex (Project Gutenberg)
    private func searchGutendex(q: String, limit: Int) async throws -> [Book] {
        guard let url = URL(string: "https://gutendex.com/books?search=\(q)") else {
            throw NetworkError.invalidURL
        }

        if debugLog { print("GUTENDEX URL:", url.absoluteString) }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        if debugLog { print("GUTENDEX STATUS:", http.statusCode) }

        guard (200...299).contains(http.statusCode) else {
            let bodyString = String(data: data, encoding: .utf8)
            if debugLog { print("GUTENDEX ERROR BODY:", bodyString ?? "nil") }
            throw NetworkError.httpError(statusCode: http.statusCode, body: bodyString)
        }

        guard !data.isEmpty else { throw NetworkError.emptyData }

        let decoded: GutendexResponse
        do {
            decoded = try JSONDecoder().decode(GutendexResponse.self, from: data)
        } catch {
            if debugLog { print("GUTENDEX DECODING ERROR:", error) }
            throw NetworkError.decodingError(error)
        }

        let items = Array(decoded.results.prefix(limit))

        let books: [Book] = items.map { item in
            let title = item.title ?? "Untitled"
            let author = item.authors?.first?.name ?? "Unknown"

            
            let formats = item.formats ?? [:]
            let reader =
                formats["text/html"] ??
                formats["text/html; charset=utf-8"] ??
                formats["application/epub+zip"] ??
                formats.values.first

            let cover = formats["image/jpeg"]

            return Book(
                id: "gutenberg-\(item.id ?? Int.random(in: 100000...999999))",
                title: title,
                author: author,
                isbn: "",
                rating: 4.5,
                description: "Free public-domain book (Project Gutenberg).",
                coverID: nil,
                coverLink: cover,
                readerLink: reader
            )
        }

        if debugLog { print("GUTENDEX TOTAL:", books.count) }
        return books
    }

    // MARK: - OpenLibrary
    private func searchOpenLibrary(q: String, limit: Int) async throws -> [Book] {
        guard let url = URL(string: "https://openlibrary.org/search.json?q=\(q)&limit=\(limit)") else {
            throw NetworkError.invalidURL
        }

        if debugLog { print("OPENLIBRARY URL:", url.absoluteString) }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        if debugLog { print("OPENLIBRARY STATUS:", http.statusCode) }

        guard (200...299).contains(http.statusCode) else {
            let bodyString = String(data: data, encoding: .utf8)
            if debugLog { print("OPENLIBRARY ERROR BODY:", bodyString ?? "nil") }
            throw NetworkError.httpError(statusCode: http.statusCode, body: bodyString)
        }

        guard !data.isEmpty else { throw NetworkError.emptyData }

        let decoded: OpenLibraryResponse
        do {
            decoded = try JSONDecoder().decode(OpenLibraryResponse.self, from: data)
        } catch {
            if debugLog { print("OPENLIBRARY DECODING ERROR:", error) }
            throw NetworkError.decodingError(error)
        }

        let books: [Book] = decoded.docs.prefix(limit).map { doc in
            let title = doc.title ?? "Untitled"
            let author = doc.authorName?.first ?? "Unknown"
            let isbn = doc.isbn?.first ?? ""
            let id = doc.key ?? UUID().uuidString

           
            let readerLink: String? = {
                guard doc.hasFulltext == true,
                      let ia = doc.ia?.first,
                      !ia.isEmpty
                else { return nil }
                return "https://archive.org/details/\(ia)"
            }()

            return Book(
                id: id,
                title: title,
                author: author,
                isbn: isbn,
                rating: 4.3,
                description: "OpenLibrary result (may not have online reader).",
                coverID: doc.coverI,
                coverLink: nil,
                readerLink: readerLink
            )
        }

        if debugLog { print("OPENLIBRARY TOTAL:", books.count) }
        return books
    }
}

// MARK: - Gutendex Models
private struct GutendexResponse: Decodable {
    let results: [GutendexBook]
}

private struct GutendexBook: Decodable {
    let id: Int?
    let title: String?
    let authors: [GutendexAuthor]?
    let formats: [String: String]?
}

private struct GutendexAuthor: Decodable {
    let name: String?
}

// MARK: - OpenLibrary Models
private struct OpenLibraryResponse: Decodable {
    let docs: [OpenLibraryDoc]
}

private struct OpenLibraryDoc: Decodable {
    let key: String?
    let title: String?
    let authorName: [String]?
    let isbn: [String]?
    let coverI: Int?
    let hasFulltext: Bool?
    let ia: [String]?

    enum CodingKeys: String, CodingKey {
        case key, title, isbn
        case authorName = "author_name"
        case coverI = "cover_i"
        case hasFulltext = "has_fulltext"
        case ia
    }
}
