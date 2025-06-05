import SwiftUI

extension View {
    /// Applies the standard Jeune card styling to a view.
    func jeuneCard(padding: CGFloat = 16) -> some View {
        self
            .padding(padding)
            .frame(maxWidth: .infinity)
            .background(Color.jeuneCardColor)
            .cornerRadius(DesignConstants.cornerRadius)
            .shadow(
                color: DesignConstants.cardShadow,
                radius: DesignConstants.cardShadowRadius,
                x: 0,
                y: 0
            )
    }
}
