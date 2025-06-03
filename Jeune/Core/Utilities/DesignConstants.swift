import SwiftUI

/// Centralised design constants derived from `tasks.md`.
enum DesignConstants {
    /// Default corner radius for cards and buttons.
    static let cornerRadius: CGFloat = 20

    /// Shadow used for cards.
    static let cardShadow = Color.black.opacity(0.10)

    /// Toolbar button size.
    static let toolbarButtonSize: CGFloat = 34

    /// Primary call to action button height.
    static let primaryCTAHeight: CGFloat = 50

    /// Diameter of the large fasting timer ring.
    static let largeRingDiameter: CGFloat = 280

    /// Stroke width for the large fasting timer ring. Doubling the thickness
    /// further emphasises progress of the fast.
    static let largeRingLineWidth: CGFloat = 70

    /// Diameter of the mini weekday progress rings.
    static let miniRingDiameter: CGFloat = 15

    /// Stroke width for the mini weekday progress rings.
    static let miniRingLineWidth: CGFloat = 25
}