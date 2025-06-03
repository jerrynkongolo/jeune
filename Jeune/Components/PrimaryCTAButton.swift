import SwiftUI

/// Primary pill-shaped call to action.
struct PrimaryCTAButton: View {
    var title: String
    var background: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: DesignConstants.primaryCTAHeight)
                .background(background)
                .cornerRadius(12)
        }
    }
}

#Preview {
    PrimaryCTAButton(title: "Start Fasting", background: .jeunePrimaryColor) {}
}
