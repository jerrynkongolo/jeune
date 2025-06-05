import SwiftUI

/// Standard section header with optional trailing action.
struct SectionHeaderView: View {
    let title: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(title)
                .font(.callout.weight(.semibold))
                .foregroundColor(.jeuneNearBlack)
            Spacer()
            if let actionTitle {
                if let action {
                    Button(action: action) {
                        Text(actionTitle.uppercased())
                            .font(.jeuneCaptionBold)
                            .foregroundColor(.jeunePrimaryDarkColor)
                    }
                    .buttonStyle(PlainButtonStyle())
                } else {
                    Text(actionTitle.uppercased())
                        .font(.jeuneCaptionBold)
                        .foregroundColor(.jeunePrimaryDarkColor)
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 8) {
        SectionHeaderView(title: "Title")
        SectionHeaderView(title: "Title", actionTitle: "See All") {}
    }
    .padding()
}
