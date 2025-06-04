import SwiftUI

struct JeuneHomeView: View {
    @State private var progress: Double = 0.6
    @State private var streak: Int = 3

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    weekStrip
                        .padding(.bottom, 20)

                    // Updated to use full FastTimerCardView with all props
                    FastTimerCardView(
                        state: .running(progress: progress),
                        startDate: "MON, 09:41",
                        goalHours: 16,
                        goalTime: "TUE, 01:41"
                    ) {
                        // action placeholder
                    }
                    .padding(.bottom, 24)

                    ChallengesCardView()
                }
                .padding(.top, 4)
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
                        .frame(height: 100) // Adjust height as needed, aiming for good proportion across devices
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
}

#Preview {
    JeuneHomeView()
}