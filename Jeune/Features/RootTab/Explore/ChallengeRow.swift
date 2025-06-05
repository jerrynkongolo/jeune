import SwiftUI

struct ChallengeRow: View {
    let challenge: Challenge

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: challenge.image)
                .frame(width: 40, height: 40)
                .foregroundColor(.jeunePrimaryDarkColor)
                .background(Circle().fill(Color.jeuneGrayColor.opacity(0.2)))

            VStack(alignment: .leading, spacing: 4) {
                Text(challenge.tag.uppercased())
                    .font(.caption2)
                    .foregroundColor(.jeuneSuccessColor)
                Text(challenge.title)
                    .font(.headline)
                    .foregroundColor(.jeuneNearBlack)
                    .lineLimit(1)
                Text("\(challenge.duration) \u{2022} \(challenge.participants)")
                    .font(.footnote)
                    .foregroundColor(.jeuneGrayColor)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.jeuneGrayColor)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ChallengeRow(challenge: Challenge.sampleChallenges.first!)
        .padding()
}
