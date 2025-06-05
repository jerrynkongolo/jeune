import SwiftUI

/// Circular date indicator using the same thick ring style as MiniRingView.
struct DateRingView: View {
    var date: Date
    var color: Color

    private var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    var body: some View {
        VStack(spacing: 4) {
            Text(dayString)
                .font(.jeuneCaptionBold)
                .foregroundColor(.secondary)

            Circle()
                .stroke(color, lineWidth: DesignConstants.miniRingLineWidth)
                .frame(width: DesignConstants.miniRingDiameter, height: DesignConstants.miniRingDiameter)
        }
    }
}

#Preview {
    HStack(spacing: 16) {
        DateRingView(date: .now, color: .jeuneNutritionColor)
        DateRingView(date: .now, color: .jeuneRestorationColor)
    }
}
