import SwiftUI

struct JeuneHomeView: View {
    @State private var streak: Int = 3
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    weekStrip
                        .padding(.bottom, 20)
                    FastingDemoView()
                        .padding(.bottom, 24)
                    ChallengesCardView(seeAllAction: navigateToChallenges)
                }
                // Remove extra top padding so the week strip sits closer to the
                // toolbar.
                .padding(.horizontal)
            }
            .background(Color.jeuneCanvasColor.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    StreakBadgeView(count: streak)
                }

                ToolbarItem(placement: .principal) {
                    Image("logojeune")
                        .resizable()
                        .scaledToFit()
                        // Smaller height keeps the navigation bar compact
                        .frame(height: 60)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarPlusButtonView {
                        // action placeholder
                    }
                }
            }
        }
    }

    private var weekStrip: some View {
HStack(spacing: 32) {
            ForEach(0..<7) { index in
                let date = Calendar.current.date(byAdding: .day, value: index, to: Date())!
                DayIndicatorView(
                    label: weekdayLabel(for: date),
                    state: dayState(for: index)
                )
            }
        }
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity)
    }

    private func weekdayLabel(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.setLocalizedDateFormatFromTemplate("EEE")
        return formatter.string(from: date).uppercased()
    }

    private func dayState(for index: Int) -> DayIndicatorView.State {
        if index == 0 { return .selected }
        if index == 6 { return .completed }
        return .inactive
    }

    private func navigateToChallenges() {
        appState.selectedTab = .explore
        appState.exploreSegment = .challenges
    }
}

#Preview {
    JeuneHomeView()
}