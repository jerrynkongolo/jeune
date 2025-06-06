import SwiftUI

extension View {
    /// Applies the standard Jeune card styling to a view.
    func jeuneCard(padding: CGFloat = 16, background: Color = .jeuneCardColor) -> some View {
        self
            .padding(padding)
            .frame(maxWidth: .infinity)
            .background(background)
            .cornerRadius(DesignConstants.cornerRadius)
            .shadow(
                color: DesignConstants.cardShadow,
                radius: DesignConstants.cardShadowRadius,
                x: 0,
                y: 2
            )
    }
}
