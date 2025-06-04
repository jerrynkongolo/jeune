import SwiftUI

/// Placeholder card showing upcoming challenges section.
struct ChallengesCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Challenges")
                    .font(.title3.weight(.semibold))
                Spacer()
                Text("SEE ALL")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.jeunePrimaryColor)
                }

            HStack(spacing: 12) {
                Image(systemName: "flame.fill")
                    .foregroundColor(.jeunePrimaryColor)
                    .font(.title)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Join challenges to earn achievements")
                        .font(.subheadline)
                        .foregroundColor(Color(.lightGray))
                        .lineLimit(2)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.jeunePrimaryColor)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 12) // Added horizontal padding inside the gray area
            .frame(height: 76)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.94, green: 0.94, blue: 0.95))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
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

#Preview {
    ChallengesCardView()
        .padding()
}
