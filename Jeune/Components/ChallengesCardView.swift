import SwiftUI

/// Placeholder card showing upcoming challenges section.
struct ChallengesCardView: View {
    var seeAllAction: () -> Void = {}

    /// Images used to preview available challenges.
    private let challengeImages = [
        "jeune7days",
        "jeune14days",
        "jeune16hours"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Challenges")
                    .font(.callout.weight(.semibold))
                    .padding(.leading, 4)
                Spacer()
                Button(action: seeAllAction) {
                    Text("SEE ALL")
                        .font(.jeuneCaptionBold)
                        .foregroundColor(.jeunePrimaryDarkColor)
                }
                .buttonStyle(PlainButtonStyle())
            }

            HStack(spacing: 12) {
                ZStack(alignment: .topLeading) {
                    ForEach(Array(challengeImages.enumerated()), id: \.offset) { index, name in
                        Image(name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 46, height: 46)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .offset(x: CGFloat(index) * 8, y: CGFloat(index) * 8)
                    }
                }
                .frame(width: 70, height: 60, alignment: .topLeading)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Join challenges to earn achievements")
                        .font(.callout)
                        .foregroundColor(Color(.lightGray))
                        .lineLimit(2)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.jeunePrimaryDarkColor)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 12) // Added horizontal padding inside the gray area
            .frame(height: 76)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.94, green: 0.94, blue: 0.95))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .jeuneCard()
    }
}

#Preview {
    ChallengesCardView()
        .padding()
}
