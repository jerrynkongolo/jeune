import SwiftUI

/// Main explore screen displaying featured content and articles.
struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()

    @Environment(\.openURL) private var openURL: OpenURLAction


    /// Currently selected segment in the segmented menu.
    @State private var selectedSegment: ExploreSegment = .home


    @Environment(\.jeuneSafeAreaInsets) private var safeAreaInsets: EdgeInsets


    /// Approximate height of the custom header including the safe area.
    private var headerHeight: CGFloat {
        safeAreaInsets.top + 112
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Reserve space for the fixed header
                    Color.clear
                        .frame(height: headerHeight)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("FEATURED")
                            .font(.callout.weight(.semibold))
                            .foregroundColor(.jeuneNearBlack)

                        FeaturedBannerView()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .background(Color.jeuneCanvasColor.ignoresSafeArea())
            .navigationBarHidden(true)
            .overlay(alignment: .top) {
                ExploreHeaderView(selected: $selectedSegment)
            }
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

/// Explore screen segments.
private enum ExploreSegment: String, CaseIterable {
    case home = "Home"
    case learn = "Learn"
    case challenges = "Challenges"
}

/// Fixed header containing toolbar actions and the segmented menu.
private struct ExploreHeaderView: View {
    @Binding var selected: ExploreSegment

    @Environment(\.jeuneSafeAreaInsets) private var safeAreaInsets: EdgeInsets


    var body: some View {
        VStack(spacing: 9) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.jeuneDarkGray)
                Spacer()
                Text("Explore")
                    .font(.callout.weight(.semibold))
                    .foregroundColor(.jeuneNearBlack)
                Spacer()
                Image(systemName: "bookmark")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.jeuneDarkGray)
            }

            HStack(spacing: 8) {
                ForEach(ExploreSegment.allCases, id: \.self) { segment in
                    Text(segment.rawValue)
                        .font(.jeuneCaptionBold)
                        .foregroundColor(selected == segment ? .jeuneAccentColor : .jeuneDarkGray)
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .fill(selected == segment ? Color.jeuneAccentColor.opacity(0.15) : Color.clear)
                        )
                        .onTapGesture { selected = segment }
                }
            }
        }
        .padding(.top, safeAreaInsets.top + 4)
        .padding(.horizontal)
        .padding(.bottom, 12)
        .frame(maxWidth: .infinity)
        .background(Color.white.ignoresSafeArea(edges: .top))
        .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 2)
    }
}

/// Blue featured banner highlighting key content.
private struct FeaturedBannerView: View {
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ARTICLE")
                    .font(.caption.weight(.bold))
                    .foregroundColor(Color.white.opacity(0.7))

                Text("The Complete Guide to Fat Burning")
                    .font(.headline.weight(.bold))
                    .foregroundColor(.white)
                    

                Button(action: {}) {
                    Text("Read Now")
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(Color.jeunePrimaryDarkColor)
                        .clipShape(Capsule())
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

            Rectangle()
                .fill(Color.orange)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)

        .background(Color(red: 0.0, green: 0.27, blue: 0.73))

        .cornerRadius(DesignConstants.cornerRadius)
    }
}

#Preview {
    ExploreView()
}
