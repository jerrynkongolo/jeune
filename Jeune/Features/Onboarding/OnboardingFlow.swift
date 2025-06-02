import SwiftUI

struct OnboardingPage: Identifiable {
    let id = UUID()
    let symbol: String
    let title: String
    let subtitle: String
}

struct OnboardingFlow: View {
    @EnvironmentObject var appState: AppState
    @State private var pageIndex = 0

    private let pages: [OnboardingPage] = [
        OnboardingPage(symbol: "timer",
                       title: "Track your fasts",
                       subtitle: "Start, pause, or edit anytime."),
        OnboardingPage(symbol: "flame",
                       title: "Understand your zones",
                       subtitle: "See what's happening inside your body."),
        OnboardingPage(symbol: "doc.text.image",
                       title: "Learn from experts",
                       subtitle: "Daily articles & videos keep you motivated."),
        OnboardingPage(symbol: "checkmark.seal",
                       title: "Ready?",
                       subtitle: "Let’s set up your first fast.")
    ]

    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.jeunePrimaryColor)
    }

    var body: some View {
        TabView(selection: $pageIndex) {
            ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                OnboardingPageView(page: page,
                                    showSkip: index < pages.count - 1,
                                    continueAction: {
                                        if index < pages.count - 1 {
                                            withAnimation { pageIndex += 1 }
                                        } else {
                                            appState.onboardingCompleted = true
                                        }
                                    },
                                    skipAction: {
                                        withAnimation { pageIndex = pages.count - 1 }
                                    })
                .tag(index)
            }
        }
        .tabViewStyle(.page)
    }
}

private struct OnboardingPageView: View {
    let page: OnboardingPage
    let showSkip: Bool
    var continueAction: () -> Void
    var skipAction: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Spacer()

                Image(systemName: page.symbol)
                    .font(.system(size: 56))
                    .symbolRenderingMode(.multicolor)
                    .padding(.bottom, 24)

                Text(page.title)
                    .font(.jeuneLargeTitle)
                    .padding(.bottom, 8)

                Text(page.subtitle)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()

                PrimaryButton(title: "Continue", action: continueAction)
                    .padding(.bottom, 40)
            }

            if showSkip {
                Button("Skip", action: skipAction)
                    .font(.caption)
                    .textCase(.uppercase)
                    .padding([.top, .trailing], 20)
            }
        }
    }
}

#Preview {
    OnboardingFlow().environmentObject(AppState())
}
