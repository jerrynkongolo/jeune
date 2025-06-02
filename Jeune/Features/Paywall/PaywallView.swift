import SwiftUI

struct BenefitRow: View {
    let symbol: String
    let headline: String
    let sub: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: symbol)
                .font(.system(size: 24))
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 2) {
                Text(headline)
                    .font(.headline.weight(.semibold))
                Text(sub)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

enum BillingPeriod: String, CaseIterable, Identifiable {
    case annual = "Annually"
    case monthly = "Monthly"

    var id: String { rawValue }
}

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var billing: BillingPeriod = .annual

    private var priceLabel: String {
        switch billing {
        case .annual: return "Start 7-day free trial – $59.99/yr"
        case .monthly: return "Start 7-day free trial – $11.99/mo"
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    LottieView(name: "jeuneSparkle")
                        .frame(height: 200)
                        .scaledToFit()

                    Text("Upgrade to Jeune Plus")
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 16) {
                        BenefitRow(symbol: "chart.bar.xaxis", headline: "Advanced stats", sub: "Weight, heart-rate & more")
                        BenefitRow(symbol: "cross.vial", headline: "Fasting zones", sub: "See fat-burn & ketosis in real-time")
                        BenefitRow(symbol: "video", headline: "Expert library", sub: "200+ videos & meditations")
                    }
                    .padding(.horizontal)

                    Picker("Billing", selection: $billing) {
                        ForEach(BillingPeriod.allCases) { period in
                            Text(period.rawValue).tag(period)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    PrimaryButton(title: priceLabel, action: {})

                    Text("No commitment. Cancel anytime.")
                        .font(.footnote)
                        .foregroundColor(.secondary)

                    HStack {
                        Button("Restore") {}
                        Spacer()
                        Button("Privacy/Terms") {}
                    }
                    .font(.caption2)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    PaywallView()
}
