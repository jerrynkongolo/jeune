import SwiftUI

class ExploreViewModel: ObservableObject {
    @Published var query: String = ""
    @Published private(set) var articles: [Article] = Article.sampleArticles

    var filteredArticles: [Article] {
        guard !query.isEmpty else { return articles }
        let lower = query.lowercased()
        return articles.filter { article in
            article.title.lowercased().contains(lower) ||
            article.subtitle.lowercased().contains(lower) ||
            article.tag.lowercased().contains(lower)
        }
    }
}

