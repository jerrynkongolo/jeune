// Font+Jeune.swift
import SwiftUI

extension Font {
    /// Jeune Large Title: SF Pro, 28 pt, Bold.
    /// Recommended for screen headers, e.g. "Today", "Explore".
    static let jeuneLargeTitle: Font = .system(size: 28, weight: .bold)

    /// Jeune Title 2: SF Pro, 22 pt, Semibold.
    /// Recommended for card headings, modal titles.
    static let jeuneTitle2: Font = .system(size: 22, weight: .semibold)

    // As per tasks.md:
    // - For giant numbers (like timers), consider using .system(size: مناسب_كبير, weight: .regular_or_other, design: .default)
    //   SwiftUI typically selects SF Pro Display for larger sizes automatically.
    // - For body text, the default .body or .callout, etc., will use SF Pro Text.
    //   You can customize further with .system(size: X, weight: .Y) if needed.
}
