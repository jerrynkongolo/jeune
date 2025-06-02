import SwiftUI

struct FastingRingView: View {
    @Binding var progress: Double
    var lineWidth: CGFloat = 12

    private var gradient: AngularGradient {
        AngularGradient(
            gradient: Gradient(colors: [
                Color.jeunePrimaryColor,
                progress >= 1.0 ? Color.jeuneSuccessColor : Color.jeunePrimaryColor
            ]),
            center: .center
        )
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.jeunePrimaryColor.opacity(0.2), lineWidth: lineWidth)

            Circle()
                .trim(from: 0, to: min(progress, 1.0))
                .stroke(gradient, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
        }
    }
}
