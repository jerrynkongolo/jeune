import SwiftUI


/// Circular date indicator matching the week strip style on the Today screen.

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


            let strokeWidth: CGFloat = 4 * 1.25
            let ringSize = (DesignConstants.miniRingDiameter + 8) * 0.7

            Circle()
                .stroke(color, lineWidth: strokeWidth)
                .frame(width: ringSize, height: ringSize)

        }
    }
}

#Preview {
    HStack(spacing: 16) {
        DateRingView(date: .now, color: .jeuneNutritionColor)
        DateRingView(date: .now, color: .jeuneRestorationColor)
    }
}
