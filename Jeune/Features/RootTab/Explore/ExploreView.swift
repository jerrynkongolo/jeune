import SwiftUI

/// Main explore screen displaying featured content and articles.
struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()

    @Environment(\.openURL) private var openURL: OpenURLAction

    @EnvironmentObject private var appState: AppState


    /// Currently selected segment in the segmented menu.
    @State private var selectedSegment: ExploreSegment = .home
    /// Previously selected segment used to determine sweep direction.
    @State private var previousSegment: ExploreSegment = .home
    /// Direction that controls the slide transition between segment views.
    
    @State private var isForwardTransition: Bool = true
    /// Indicates when the horizontal challenge scroll view is being dragged.
    @State private var draggingChallengeScroll: Bool = false

    @Namespace private var segmentNamespace


    @Environment(\.jeuneSafeAreaInsets) private var safeAreaInsets: EdgeInsets

    /// Minimum horizontal distance before a swipe gesture triggers a segment change.
    private let swipeThreshold: CGFloat = 50


    /// Padding applied to the header. Removing a small amount keeps the
    /// toolbar consistent with the rest of the app.
    private var headerTopPadding: CGFloat {
        max(0, safeAreaInsets.top - 6)
    }

    /// Approximate height of the custom header including the safe area.
    private var headerHeight: CGFloat {
        headerTopPadding + 85
    }

    /// Binding used by the header so we can update the transition direction
    /// before changing the selected segment.
    private var segmentBinding: Binding<ExploreSegment> {
        Binding(get: { selectedSegment }) { newValue in
            updateTransitionDirection(for: newValue)
            selectedSegment = newValue
        }
    }


    /// Transition used for sweeping in the selected segment's content.
    private var sweepTransition: AnyTransition {
        if isForwardTransition {
            return .asymmetric(insertion: .move(edge: .trailing),
                               removal: .move(edge: .leading))
        } else {
            return .asymmetric(insertion: .move(edge: .leading),
                               removal: .move(edge: .trailing))
        }
    }

    /// Updates the direction for the transition based on the newly selected segment.
    private func updateTransitionDirection(for newValue: ExploreSegment) {
        let cases = ExploreSegment.allCases
        if let newIndex = cases.firstIndex(of: newValue),
           let oldIndex = cases.firstIndex(of: previousSegment) {
            isForwardTransition = newIndex > oldIndex
        } else {
            isForwardTransition = true
        }
        previousSegment = newValue
    }

    /// Changes the selected segment in the given direction if possible.
    private func moveSegment(forward: Bool) {
        let cases = ExploreSegment.allCases
        guard let index = cases.firstIndex(of: selectedSegment) else { return }
        let newIndex = forward ? index + 1 : index - 1
        guard cases.indices.contains(newIndex) else { return }
        let newSegment = cases[newIndex]
        updateTransitionDirection(for: newSegment)

        withAnimation(.spring(response: 0.55, dampingFraction: 0.8)) {
            selectedSegment = newSegment
        }
    }

    /// Gesture that detects horizontal swipes to change segments.
    private var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 20)
            .onEnded { value in

                guard !draggingChallengeScroll else { return }

                let horizontal = value.translation.width
                let vertical = value.translation.height
                guard abs(horizontal) > abs(vertical), abs(horizontal) > swipeThreshold else { return }
                if horizontal < 0 {
                    moveSegment(forward: true)
                } else {
                    moveSegment(forward: false)
                }
            }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Reserve space for the fixed header
                    Color.clear
                        .frame(height: headerHeight)


                    ZStack {
                        if selectedSegment == .home { homeContent.transition(sweepTransition) }
                        if selectedSegment == .learn { learnContent.transition(sweepTransition) }
                        if selectedSegment == .challenges { challengesContent.transition(sweepTransition) }

                    }
                    .animation(
                        .spring(response: 0.55, dampingFraction: 0.8)
                            .delay(0.05),
                        value: selectedSegment
                    )

                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .background(Color.jeuneCanvasColor.ignoresSafeArea())
            .simultaneousGesture(swipeGesture)
            .navigationBarHidden(true)
            .overlay(alignment: .top) {
                ExploreHeaderView(selected: segmentBinding, animation: segmentNamespace)

            }
            .onAppear {
                selectedSegment = appState.exploreSegment
            }
            .onChange(of: selectedSegment) { newValue in
                appState.exploreSegment = newValue
            }
            .onChange(of: appState.exploreSegment) { newValue in
                guard newValue != selectedSegment else { return }
                updateTransitionDirection(for: newValue)
                selectedSegment = newValue
            }
        }
    }


    private var homeContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeaderView(title: "Featured")

            FeaturedBannerView()
                .padding(.bottom, 12)

            SectionHeaderView(
                title: "Try Challenge",
                actionTitle: "See All",
                action: { appState.exploreSegment = .challenges }
            )

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Challenge.sampleChallenges) { challenge in
                        ChallengeCardView(challenge: challenge)
                    }
                }
                .padding(.horizontal, 4)
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in draggingChallengeScroll = true }
                    .onEnded { _ in draggingChallengeScroll = false }
            )

            .scrollClipDisabled()
            .padding(.vertical, 4)

        }
    }

    private var learnContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeaderView(title: "ARTICLES")

            ForEach(viewModel.filteredArticles) { article in
                ArticleRow(article: article)
            }
        }
    }

    private var challengesContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeaderView(title: "Featured")

            ChallengeBannerView()

                .padding(.bottom, 12)

            SectionHeaderView(title: "Join a Challenge")
                
            VStack(spacing: 0) {
                ForEach(Challenge.sampleChallenges) { challenge in
                    NavigationLink(destination: Text(challenge.title)) {
                        ChallengeRow(challenge: challenge)
                    }

                    if challenge.id != Challenge.sampleChallenges.last?.id {
                        Divider()
                            .background(Color.jeuneGrayColor.opacity(0.3))
                    }
                }
            }
            .jeuneCard()

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



/// Fixed header containing toolbar actions and the segmented menu.
private struct ExploreHeaderView: View {
    @Binding var selected: ExploreSegment
    var animation: Namespace.ID

    @Environment(\.jeuneSafeAreaInsets) private var safeAreaInsets: EdgeInsets


    var body: some View {

        // Increased spacing to better separate rows
        VStack(spacing: 18) {

            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.jeuneDarkGray)
                Spacer()
                Text("Explore")
                    .font(.callout.weight(.semibold))
                    .foregroundColor(.jeuneNearBlack)
                Spacer()
                NavigationLink(destination: BookmarkView()) {
                    Image(systemName: "bookmark")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.jeuneDarkGray)
                }
            }

            HStack(spacing: 8) {
                ForEach(ExploreSegment.allCases, id: \.self) { segment in
                    Text(segment.rawValue)
                        .font(.jeuneCaptionBold)
                        .foregroundColor(selected == segment ? .jeuneAccentColor : .jeuneDarkGray)
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                if selected == segment {
                                    Capsule()
                                        .fill(Color.jeuneAccentColor.opacity(0.15))
                                        .matchedGeometryEffect(id: "SEGMENT_BUBBLE", in: animation)
                                }
                            }
                        )
                        .contentShape(Rectangle())
                        .onTapGesture {

                            withAnimation(.spring(response: 0.55, dampingFraction: 0.8)) {
                                selected = segment

                            }
                        }
                }
            }
        }

        // Remove extra offset to tighten space below the notch
        .padding(.top, max(0, safeAreaInsets.top - 6))

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
        .frame(height: 180)

        .background(Color(red: 0.0, green: 0.27, blue: 0.73))

        .cornerRadius(DesignConstants.cornerRadius)
    }
}

#Preview {
    ExploreView()
}
