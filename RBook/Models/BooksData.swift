//
//  BooksData.swift
//  RBookApp
//
//  Created by Aisha Hudasi on 24/06/1447 AH.
//
import Foundation

// MARK: - Featured Books
let featuredBooks: [Book] = [
    Book(
        title: "قوة العادات",
        author: "تشارلز دويج",
        isbn: "9780812981605",
        rating: 4.7,
        description: "كتاب يشرح كيف تتكوّن العادات ولماذا ننجح أو نفشل في تغييرها، مع أمثلة واقعية تساعد على تحسين الحياة الشخصية والعملية."
    ),
    Book(
        title: "Deep Work",
        author: "Cal Newport",
        isbn: "9781455586691",
        rating: 4.5,
        description: "How to focus deeply in a distracted world and achieve meaningful results."
    ),
    Book(
        title: "Start With Why",
        author: "Simon Sinek",
        isbn: "9781591846444",
        rating: 4.6,
        description: "Explains how leaders inspire action by starting with purpose."
    ),
    Book(
        title: "Mindset",
        author: "Carol S. Dweck",
        isbn: "9780345472328",
        rating: 4.6,
        description: "Shows how adopting a growth mindset can unlock learning and success."
    ),
    Book(
        title: "7 Habits",
        author: "Stephen R. Covey",
        isbn: "9780743269513",
        rating: 4.7,
        description: "A principle-centered approach to personal and professional effectiveness."
    ),
    Book(
        title: "Thinking, Fast and Slow",
        author: "Daniel Kahneman",
        isbn: "9780374533557",
        rating: 4.6,
        description: "Explores how we think, make decisions, and avoid cognitive biases."
    )
]

// MARK: - Home Sections

let homeSections: [BookSection] = [
    BookSection(title: "Education", books: [
        Book(title: "Make It Stick", author: "Peter C. Brown", isbn: "9780674729018", rating: 4.6, description: "Science-backed methods to learn better and remember longer."),
        Book(title: "How Learning Works", author: "Susan A. Ambrose", isbn: "9780470484104", rating: 4.5, description: "Practical principles for effective learning and teaching."),
        Book(title: "Learning How to Learn", author: "Barbara Oakley", isbn: "9780143132547", rating: 4.7, description: "Powerful mental tools to master tough subjects."),
        Book(title: "Educated", author: "Tara Westover", isbn: "9780399590504", rating: 4.7, description: "A memoir about education, growth, and self-invention."),
        Book(title: "The Talent Code", author: "Daniel Coyle", isbn: "9780553806847", rating: 4.4, description: "How skills are built through deep practice and coaching.")
    ]),
    BookSection(title: "Cultural", books: [
        Book(title: "Sapiens", author: "Yuval Noah Harari", isbn: "9780062316110", rating: 4.7, description: "A brief history of humankind and how we shaped the world."),
        Book(title: "Homo Deus", author: "Yuval Noah Harari", isbn: "9780062464316", rating: 4.6, description: "A look at the future of humanity and what comes next."),
        Book(title: "A Short History", author: "Bill Bryson", isbn: "9780767908184", rating: 4.6, description: "A fun, readable tour through science and human history."),
        Book(title: "The Silk Roads", author: "Peter Frankopan", isbn: "9781101912379", rating: 4.4, description: "A new history of the world told through trade routes."),
        Book(title: "Factfulness", author: "Hans Rosling", isbn: "9781250107817", rating: 4.6, description: "A calmer, data-driven way to see the world.")
    ]),
    BookSection(title: "Business", books: [
        Book(title: "The Psychology of Money", author: "Morgan Housel", isbn: "9780857197689", rating: 4.7, description: "Timeless lessons on wealth, greed, and happiness."),
        Book(title: "The Lean Startup", author: "Eric Ries", isbn: "9780307887894", rating: 4.6, description: "Build products faster with validated learning."),
        Book(title: "Zero to One", author: "Peter Thiel", isbn: "9780804139298", rating: 4.4, description: "Notes on startups and building the future."),
        Book(title: "Good to Great", author: "Jim Collins", isbn: "9780066620992", rating: 4.5, description: "Why some companies make the leap and others don’t."),
        Book(title: "Rich Dad Poor Dad", author: "Robert Kiyosaki", isbn: "9781612680194", rating: 4.5, description: "Mindset shifts around money and financial literacy.")
    ]),
    BookSection(title: "Arabic", books: [
        Book(title: "العادات السبع للناس الأكثر فاعلية", author: "ستيفن كوفي", isbn: "9781471195709", rating: 4.8, description: "كتاب تنمية ذاتية عالمي يقدّم سبع عادات أساسية للنجاح الشخصي والمهني."),
        Book(title: "فكر تصبح غنياً", author: "نابليون هيل", isbn: "9781585424337", rating: 4.6, description: "كتاب كلاسيكي في تطوير الذات يركّز على العقلية الإيجابية وبناء النجاح."),
        Book(title: "دع القلق وابدأ الحياة", author: "ديل كارنيجي", isbn: "9780671733353", rating: 4.7, description: "إرشادات عملية للتخلص من القلق وبناء حياة أكثر هدوءاً وثقة."),
        Book(title: "قوة الآن", author: "إكهارت تول", isbn: "9781577314806", rating: 4.6, description: "يعزز الوعي باللحظة الحالية لتحسين الصحة النفسية والتركيز."),
        Book(title: "الأب الغني الأب الفقير", author: "روبرت كيوساكي", isbn: "9781612680194", rating: 4.7, description: "يبسّط مفاهيم المال والاستثمار وبناء الاستقلال المالي.")
    ]),
    BookSection(title: "Kids", books: [
        Book(title: "Harry Potter and the Sorcerer's Stone", author: "J.K. Rowling", isbn: "9780439708180", rating: 4.8, description: "A young wizard discovers his destiny at Hogwarts."),
        Book(title: "Charlotte's Web", author: "E. B. White", isbn: "9780061124952", rating: 4.7, description: "A touching friendship that saves a little pig."),
        Book(title: "Matilda", author: "Roald Dahl", isbn: "9780142410370", rating: 4.6, description: "A brilliant girl with a love of books and a secret power."),
        Book(title: "The Gruffalo", author: "Julia Donaldson", isbn: "9780142403877", rating: 4.5, description: "A clever mouse invents a monster in the forest."),
        Book(title: "Diary of a Wimpy Kid", author: "Jeff Kinney", isbn: "9780810993136", rating: 4.6, description: "Funny middle-school life through a kid’s diary.")
    ])
]
