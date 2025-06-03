import SwiftUI

/// Capsule badge used in the home toolbar to indicate streak count.
struct StreakBadgeView: View {
    var count: Int

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "checkmark")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)

            Text("\(count)")
                .font(.system(size: 12))
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.jeuneSuccessTintColor)
        .clipShape(Capsule())
    }
}

#Preview {
    VStack {
        StreakBadgeView(count: 0)
        StreakBadgeView(count: 5)
    }
}
