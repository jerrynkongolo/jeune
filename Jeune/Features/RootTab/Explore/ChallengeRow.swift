import SwiftUI

struct ChallengeRow: View {
    let challenge: Challenge

    var body: some View {
        HStack(spacing: 12) {

            Image(challenge.image)
                .resizable()
                .scaledToFit()
                .frame(width: 46, height: 46)
                .clipShape(Circle())
                .background(
                    Circle()
                        .fill(Color.jeuneGrayColor.opacity(0.2))
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(challenge.tag.uppercased())

                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.jeuneSuccessColor)
                Text(challenge.title)
                    .font(.callout.weight(.semibold))
                    .foregroundColor(.jeuneNearBlack)
                    .lineLimit(1)
                Text("\(challenge.duration) \u{2022} \(challenge.participants)")
                    .font(.system(size: 10))

                    .foregroundColor(.jeuneGrayColor)
            }

            Spacer()

            Image(systemName: "chevron.right")

                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.jeuneGrayColor)
                .padding(.trailing, 4)

        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ChallengeRow(challenge: Challenge.sampleChallenges.first!)
        .padding()
}
