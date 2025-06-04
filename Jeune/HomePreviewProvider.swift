import SwiftUI

struct HomePreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            JeuneHomeView()
            
            FastTimerCardView(
                state: .running(progress: 0.75),
                startDate: "MON, 09:41",
                goalHours: 16,
                goalTime: "TUE, 01:41"
            ) {}
            .padding()
            
            FastTimerCardView(
                state: .idle(seconds: 26_741),
                startDate: "--",
                goalHours: 16,
                goalTime: "--"
            ) {}
            .padding()
        }
    }
}