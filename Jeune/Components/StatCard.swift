import SwiftUI

struct StatCard: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.jeunePrimaryColor)
            Text(title)
                .font(.caption)
                .foregroundColor(.jeuneGrayColor)
            Text(value)
                .font(.headline)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.jeuneBGLightColor)
        .cornerRadius(12)
    }
}
