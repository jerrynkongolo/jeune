import SwiftUI

/// Circular badge used in the home toolbar to indicate streak count.
struct StreakBadgeView: View {
    var count: Int

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            ZStack {
                Circle()
                    .fill(Color.jeuneSuccessTintColor)
                    .frame(width: DesignConstants.toolbarButtonSize,
                           height: DesignConstants.toolbarButtonSize)
                Image(systemName: "checkmark")
                    .font(.system(size: 12, weight: .semibold))
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
