import SwiftUI

/// Banner promoting the featured challenge.
struct ChallengeBannerView: View {
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text("CHALLENGE")
                    .font(.caption.weight(.bold))
                    .foregroundColor(Color.white.opacity(0.7))

                Text("Three Month Fasting Challenge")
                    .font(.headline.weight(.bold))
                    .foregroundColor(.white)

                Button(action: {}) {
                    Text("Join Now")
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(Color.jeunePrimaryDarkColor)
                        .clipShape(Capsule())
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

            Rectangle()
                .fill(Color.orange)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(Color.jeunePrimaryDarkColor)
        .cornerRadius(DesignConstants.cornerRadius)
    }
}

#Preview {
    ChallengeBannerView()
        .padding()
}
