import SwiftUI

/// Row used in the settings screen with customizable trailing content.
struct SettingRow<Content: View>: View {
    let title: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.jeuneNearBlack)
            Spacer()
            content()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    SettingRow(title: "Example") { Image(systemName: "chevron.right") }
        .padding()
}
