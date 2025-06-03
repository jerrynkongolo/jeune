import SwiftUI

/// Circular plus button used in the home toolbar.
struct ToolbarPlusButtonView: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(.jeunePrimaryColor)
                .frame(width: DesignConstants.toolbarButtonSize,
                       height: DesignConstants.toolbarButtonSize)
                .background(Color.jeuneToolbarCircleColor)
                .clipShape(Circle())
        }
    }
}

#Preview {
    ToolbarPlusButtonView(action: {})
}
