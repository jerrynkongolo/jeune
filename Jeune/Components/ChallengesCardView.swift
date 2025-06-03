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
                    .font(.caption.bold())
                    .foregroundColor(.jeunePrimaryColor)
            }

            HStack(spacing: 12) {
                Image(systemName: "flame.fill")
                    .foregroundColor(.jeunePrimaryColor)
                    .font(.title2)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Join challenges to earn achievements")
                        .font(.subheadline)
                        .lineLimit(2)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.jeunePrimaryColor)
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.94, green: 0.94, blue: 0.95))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(Color.jeuneCardColor)
        .cornerRadius(DesignConstants.cornerRadius)
        .shadow(color: DesignConstants.cardShadow, radius: 10, y: 1)
    }
}

#Preview {
    ChallengesCardView()
        .padding()
}
