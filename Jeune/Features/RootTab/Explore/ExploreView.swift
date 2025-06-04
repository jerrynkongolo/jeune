// ExploreView.swift
import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()
    @Environment(\.openURL) private var openURL

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredArticles) { article in
                    ArticleRow(article: article)
                        .onTapGesture { openURL(article.url) }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Explore")
            .searchable(text: $viewModel.query)
        }
    }
}

private struct ArticleRow: View {
    let article: Article

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: article.thumb) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.jeuneGrayColor.opacity(0.2)
            }
            .frame(width: 88, height: 88)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(article.tag.uppercased())
                    .font(.caption2)
                    .foregroundColor(.jeunePrimaryDarkColor)
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(article.subtitle)
                    .font(.footnote)
                    .foregroundColor(.jeuneGrayColor)
                    .lineLimit(1)
            }
        }
        .listRowSeparator(.hidden)
    }
}

#Preview {
    ExploreView()
}

