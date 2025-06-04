import SwiftUI

/// Primary pill-shaped call to action.
struct PrimaryCTAButton: View {
    var title: String
    var background: Color
    var foreground: Color = .white
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(foreground)
                .frame(maxWidth: .infinity)
                .frame(height: DesignConstants.primaryCTAHeight)
                .background(background)
                .clipShape(Capsule()) // Retains the pill-shaped design
        }
    }
}

#Preview {
    PrimaryCTAButton(title: "Start Fasting", background: .jeunePrimaryDarkColor, foreground: .white) {}
}