import SwiftUI

/// Small label with a colored dot used in legends.
struct LegendItem: View {
    let color: Color
    let label: String

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            Text(label)
                .font(.jeuneCaptionBold)
                .foregroundColor(.jeuneGrayColor)
        }
    }
}

#Preview {
    LegendItem(color: .jeuneNutritionColor, label: "Nutrition")
        .padding()
}
