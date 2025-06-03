import SwiftUI

struct HomePreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            JeuneHomeView()
            FastTimerCardView(state: .running(progress: 0.75),
                              startDate: "9:41 AM",
                              goalHours: 16,
                              goalTime: "1:41 AM") {}
                .padding()
            FastTimerCardView(state: .idle(days: 135),
                              startDate: "--",
                              goalHours: 16,
                              goalTime: "--") {}
                .padding()
        }
    }
}
