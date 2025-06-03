// StreakBadgeView.swift
import SwiftUI

struct StreakBadgeView: View {
    let streakCount: Int

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            ZStack {
                Circle()
                    .fill(Color.jeuneSuccessTintColor)
                    .frame(width: 34, height: 34)

                Image(systemName: "checkmark")
                    .font(.system(size: 12, weight: .semibold)) // Adjusted weight for visibility
                    .foregroundColor(.white)
            }

            Text("\(streakCount)")
                .font(.caption.weight(.semibold))
                .foregroundColor(Color.jeuneGrayColor) // Assuming secondary color for the text
        }
    }
}

#if DEBUG
struct StreakBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        StreakBadgeView(streakCount: 3)
            .padding()
            .background(Color.gray.opacity(0.2))
            .previewLayout(.sizeThatFits)
    }
}
#endif
