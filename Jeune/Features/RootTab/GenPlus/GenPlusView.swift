import SwiftUI

struct GenPlusView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    header
                    features
                    ctaButton
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .background(Color.jeuneCanvasColor.ignoresSafeArea())
            .navigationTitle("Jeune+")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var header: some View {
        VStack(spacing: 8) {
            Image(systemName: "flame.fill")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.jeuneAccentColor)
            Text("Unlock Your Full Potential")
                .font(.title.weight(.bold))
                .multilineTextAlignment(.center)
            Text("Upgrade to Jeune+ for exclusive features and personalized insights.")
                .font(.subheadline)
                .foregroundColor(.jeuneGrayColor)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 24)
    }

    private var features: some View {
        VStack(alignment: .leading, spacing: 24) {
            FeatureRow(icon: "chart.bar.xaxis", title: "Advanced Analytics", description: "Track your progress with detailed charts and graphs.")
            FeatureRow(icon: "person.crop.circle.badge.questionmark", title: "Fasting Zones", description: "Discover what's happening in your body during your fast.")
            FeatureRow(icon: "book.closed.fill", title: "Premium Content", description: "Access exclusive articles, videos, and guided fasts.")
            FeatureRow(icon: "slider.horizontal.3", title: "Custom Plans", description: "Create personalized fasting plans tailored to your goals.")
        }
    }

    private var ctaButton: some View {
        Button(action: {}) {
            Text("Unlock All Features")
                .font(.headline.weight(.bold))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.jeuneAccentColor)
                .cornerRadius(12)
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.jeuneAccentColor)
                .frame(width: 48)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline.weight(.bold))
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.jeuneGrayColor)
            }
        }
    }
}

#Preview {
    GenPlusView()
}
