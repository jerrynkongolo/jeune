import SwiftUI

/// Displays articles saved by the user.
/// Shows a placeholder message when no bookmarks exist.
struct BookmarkView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "bookmark")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.jeuneGrayColor)
            Text("No bookmarks yet")
                .font(.callout.weight(.semibold))
                .foregroundColor(.jeuneDarkGray)
            Text("Articles you save will appear here.")
                .font(.footnote)
                .foregroundColor(.secondary)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.jeuneCanvasColor.ignoresSafeArea())
        .navigationTitle("Bookmarks")
        .navigationBarTitleDisplayMode(.inline)
        // Explicitly show the navigation bar to enable swipe back gesture.
        .navigationBarHidden(false)
    }
}

#Preview {
    BookmarkView()
}
