import SwiftUI

/// Circular badge used in the home toolbar to indicate streak count.
struct StreakBadgeView: View {
    var count: Int

    private var backgroundColor: Color {
        count > 0 ? .jeunePrimaryColor : .jeuneRingTrackColor
    }

    var body: some View {
        HStack(spacing: 4) {
            ZStack {
                Circle()
                    .fill(backgroundColor)
                    .frame(width: DesignConstants.toolbarButtonSize,
                           height: DesignConstants.toolbarButtonSize)
                Image(systemName: "checkmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
            }

            Text("\(count)")
                .font(.caption.weight(.semibold))
        }
    }
}

#Preview {
    VStack {
        StreakBadgeView(count: 0)
        StreakBadgeView(count: 5)
    }
}
