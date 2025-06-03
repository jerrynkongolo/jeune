import SwiftUI

struct JeuneHomeView: View {
    @State private var progress: Double = 0.6
    @State private var streak: Int = 3

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    weekStrip
                    FastTimerCardView(state: .running(progress: progress)) {
                        // action placeholder
                    }
                    ChallengesCardView()
                }
                .padding(.top, 24)
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
                        .frame(height: 24)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(width: DesignConstants.toolbarButtonSize,
                                   height: DesignConstants.toolbarButtonSize)
                            .background(Color.jeunePrimaryColor)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }

    private var weekStrip: some View {
        HStack(spacing: 20) {
            ForEach(0..<7) { index in
                MiniRingView(progress: Double(index) / 6, weekday: weekdayLabel(for: index))
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
