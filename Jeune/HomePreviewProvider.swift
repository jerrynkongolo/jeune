import SwiftUI

struct HomePreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            JeuneHomeView()
            FastTimerCardView(state: .running(progress: 0.75)) {}
                .padding()
            FastTimerCardView(state: .idle(days: 135)) {}
                .padding()
        }
    }
}
