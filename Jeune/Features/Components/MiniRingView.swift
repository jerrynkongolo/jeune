// MiniRingView.swift
import SwiftUI

struct MiniRingView: View {
    let dayLabel: String
    let progress: Double // 0.0 to 1.0
    let isComplete: Bool // True if progress >= 1.0

    private var ringColor: Color {
        isComplete ? Color.jeuneSuccessColor : Color.jeunePrimaryColor
    }

    var body: some View {
        VStack(spacing: 4) { // Spacing between label and ring
            Text(dayLabel.uppercased())
                .font(.caption2.bold())
                .foregroundColor(Color.jeuneGrayColor) // Secondary color

            ZStack {
                Circle() // Track
                    .stroke(Color.jeuneRingTrackColor, lineWidth: 6)
                
                Circle() // Progress
                    .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                    .stroke(ringColor, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .rotationEffect(.degrees(-90)) // Start from the top
            }
            .frame(width: 26, height: 26)
        }
    }
}

#if DEBUG
struct MiniRingView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 16) {
            MiniRingView(dayLabel: "Mon", progress: 0.75, isComplete: false)
            MiniRingView(dayLabel: "Tue", progress: 1.0, isComplete: true)
            MiniRingView(dayLabel: "Wed", progress: 0.25, isComplete: false)
            MiniRingView(dayLabel: "Thu", progress: 0.0, isComplete: false)
        }
        .padding()
        .background(Color.jeuneBGLightColor)
        .previewLayout(.sizeThatFits)
    }
}
#endif
