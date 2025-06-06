import SwiftUI

/// Circular progress ring used throughout the home screen.
struct RingView: View {
    var progress: Double
    var diameter: CGFloat
    var lineWidth: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.jeuneStatsBGColor, lineWidth: lineWidth)

            Circle()
                .trim(from: 0, to: min(progress, 1))
                .stroke(Color.jeunePrimaryDarkColor,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.6), value: progress)
        }
        .frame(width: diameter, height: diameter)
    }
}

#Preview {
    RingView(progress: 0.7, diameter: 100, lineWidth: 12)
}
