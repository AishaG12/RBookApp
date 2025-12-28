//
//  ExploreView.swift
//  RBookApp
//
//  Created by Aisha Hudasi on 25/06/1447 AH.
//


import SwiftUI

struct ExploreView: View {

    @StateObject private var vm = ExploreViewModel()

    var body: some View {
        VStack(spacing: 12) {

            
            HStack {
                TextField("Search books", text: $vm.query)
                    .keyboardType(.asciiCapable)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(12)
                    .background(Color.gray.opacity(0.12))
                    .cornerRadius(15)

                Button("Search") {
                    vm.search()
                }
            }
            .padding(.horizontal)
            .padding(.top, 6)

           
            if vm.isLoading {
                ProgressView()
                    .padding()
            }

            
            if let error = vm.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }

            
            if !vm.isLoading,
               vm.errorMessage == nil,
               !vm.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
               vm.results.isEmpty {

                VStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 34))
                        .foregroundColor(.gray)

                    Text("No results found")
                        .font(.headline)

                    Text("Try another keyword")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)

            } else if !vm.results.isEmpty {

                ScrollView {
                    LazyVStack(spacing: 14) {
                        ForEach(vm.results) { book in
                            NavigationLink {
                                BookDetailsView(book: book)
                            } label: {
                                BookRow(book: book)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
            }

            Spacer(minLength: 0) 
        }
        .navigationTitle("Explore")
    }
}
