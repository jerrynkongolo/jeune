import SwiftUI

/// Placeholder achievements screen.
struct AchievementsView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "star.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.jeunePrimaryDarkColor)

                Text("Achievements")
                    .font(.title2.bold())

                Text("Coming soon...")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Achievements")
            .background(Color.jeuneCanvasColor.ignoresSafeArea())
        }
    }
}

#Preview {
    AchievementsView()
}
