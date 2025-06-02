import Foundation

struct Article: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let tag: String
    let thumb: URL
    let url: URL
}

#if DEBUG
extension Article {
    static let sampleArticles: [Article] = [
        Article(title: "Fasting 101",
                subtitle: "Beginner's guide",
                tag: "Fast",
                thumb: URL(string: "https://example.com/thumb1.jpg")!,
                url: URL(string: "https://example.com/article1")!),
        Article(title: "Benefits of Intermittent Fasting",
                subtitle: "Why it works",
                tag: "Health",
                thumb: URL(string: "https://example.com/thumb2.jpg")!,
                url: URL(string: "https://example.com/article2")!),
        Article(title: "Staying Motivated",
                subtitle: "Tips to keep going",
                tag: "Mindset",
                thumb: URL(string: "https://example.com/thumb3.jpg")!,
                url: URL(string: "https://example.com/article3")!)
    ]
}
#endif

