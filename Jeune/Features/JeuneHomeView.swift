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
                        startDate: "9:41 AM",
                        goalHours: 16,
                        goalTime: "1:41 AM"
                    ) {
                        // action placeholder
                    }
                    .padding(.bottom, 24)

                    ChallengesCardView()
                }
                .padding(.top, 12)
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
                        .frame(height: 32)
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
        HStack(spacing: 16) {
            ForEach(0..<7) { index in
                MiniRingView(
                    progress: Double(index) / 6,
                    weekday: weekdayLabel(for: index)
                )
            }
        }
        .frame(maxWidth: .infinity)
    }

    private func weekdayLabel(for index: Int) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.setLocalizedDateFormatFromTemplate("EEE")
        let date = Calendar.current.date(byAdding: .day, value: index, to: startOfWeek())!
        return formatter.string(from: date).uppercased()
    }

    private func startOfWeek() -> Date {
        let cal = Calendar.current
        let comps = cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        return cal.date(from: comps) ?? Date()
    }
}

#Preview {
    JeuneHomeView()
}