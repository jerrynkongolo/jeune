import SwiftUI

/// Small ring with a weekday label underneath.
struct MiniRingView: View {
    var progress: Double
    var weekday: String

    var body: some View {
        VStack(spacing: 4) {
            RingView(progress: progress,
                     diameter: 30,
                     lineWidth: 4)
            Text(weekday)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    MiniRingView(progress: 0.5, weekday: "MON")
}
