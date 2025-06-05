import SwiftUI

/// Small vertical card used in the Explore home section.
struct ChallengeCardView: View {
    let challenge: Challenge

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(challenge.image)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .frame(maxWidth: .infinity)

            Text(challenge.tag.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.jeuneSuccessColor)

            Text(challenge.title)
                .font(.footnote.weight(.semibold))
                .foregroundColor(.jeuneNearBlack)
                .fixedSize(horizontal: false, vertical: true)

            Text("\(challenge.duration) \u{2022} \(challenge.participants)")
                .font(.caption2)
                .foregroundColor(.jeuneGrayColor)
        }
        .padding(12)
        .frame(width: 170, alignment: .leading)
        .background(Color.jeuneCardColor)
        .cornerRadius(DesignConstants.cornerRadius)
        .shadow(color: DesignConstants.cardShadow,
                radius: DesignConstants.cardShadowRadius,
                x: 0,
                y: 2)
    }
}

#Preview {
    ChallengeCardView(challenge: Challenge.sampleChallenges.first!)
        .padding()
}
