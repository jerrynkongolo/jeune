import SwiftUI

/// Placeholder card showing upcoming challenges section.
struct ChallengesCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Challenges")
                    .font(.callout.weight(.semibold))
                Spacer()
                Text("SEE ALL")
                    .font(.jeuneCaptionBold)
                    .foregroundColor(.jeunePrimaryDarkColor)
                }

            HStack(spacing: 12) {
                Image(systemName: "flame.fill")
                    .foregroundColor(.jeunePrimaryDarkColor)
                    .font(.title)
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
