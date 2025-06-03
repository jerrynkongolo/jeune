import SwiftUI

/// Centralised design constants derived from `tasks.md`.
enum DesignConstants {
    /// Default corner radius for cards and buttons.
    static let cornerRadius: CGFloat = 24

    /// Shadow used for cards.
    static let cardShadow = Color.black.opacity(0.05)

    /// Toolbar button size.
    static let toolbarButtonSize: CGFloat = 34

    /// Primary call to action button height.
    static let primaryCTAHeight: CGFloat = 54

    /// Diameter of the large fasting timer ring.
    static let largeRingDiameter: CGFloat = 260

    /// Stroke width for the large fasting timer ring.
    static let largeRingLineWidth: CGFloat = 12

    /// Diameter of the mini weekday progress rings.
    static let miniRingDiameter: CGFloat = 30

    /// Stroke width for the mini weekday progress rings.
    static let miniRingLineWidth: CGFloat = 4
}
