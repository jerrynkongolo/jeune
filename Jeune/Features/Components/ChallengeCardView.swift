// ChallengeCardView.swift
import SwiftUI

struct ChallengeCardView: View {
    // Placeholder ViewModel data
    @State var hasActiveChallenge: Bool = false // Toggle this to see both states
    @State var challengeName: String = "7-Day Streak Challenge"
    @State var challengeProgress: Double = 3.0 / 7.0 // Example: Day 3 of 7
    @State var challengeProgressText: String = "Day 3 of 7"

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Challenges")
                .font(.title3.weight(.semibold))
                .foregroundColor(Color.primary)
            
            Text("Join a challenge to boost your progress")
                .font(.callout)
                .foregroundColor(Color.jeuneGrayColor)
                .padding(.bottom, 8) // Extra spacing after subtitle

            if hasActiveChallenge {
                // Active Challenge View
                VStack(alignment: .leading, spacing: 8) {
                    Text(challengeName)
                        .font(.headline.weight(.semibold))
                        .foregroundColor(Color.primary)
                    
                    ProgressView(value: challengeProgress)
                        .tint(Color.jeunePrimaryColor)
                    
                    Text(challengeProgressText)
                        .font(.caption)
                        .foregroundColor(Color.jeuneGrayColor)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.jeuneStatsBGColor) // Using a light bg for contrast
                .cornerRadius(16) // Inner corner radius for the active challenge box

            } else {
                // Empty State View
                VStack(spacing: 16) {
                    Image(systemName: "figure.run.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(Color.jeunePrimaryColor)
                    
                    Text("No active challenges")
                        .font(.body)
                        .foregroundColor(Color.jeuneGrayColor)
                    
                    Button(action: {
                        // Action for Explore Challenges button
                        print("Explore Challenges tapped")
                    }) {
                        Text("Explore Challenges")
                            .font(.callout.bold())
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .frame(height: 44) // Slightly smaller CTA
                            .background(Color.jeunePrimaryColor)
                            .clipShape(Capsule(style: .continuous))
                    }
                }
                .padding(.vertical, 20) // Add some padding to center the empty state content
                .frame(maxWidth: .infinity)
            }
        }
        .padding(16) // Inner padding for the card content
        .background(Color.jeuneCardColor)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.10), radius: 20, x: 0, y: 2)
        .padding(.horizontal, 16) // Outer horizontal padding from screen edge
    }
}

#if DEBUG
struct ChallengeCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChallengeCardView(hasActiveChallenge: false)
                .previewDisplayName("Empty State")
            
            ChallengeCardView(hasActiveChallenge: true, challengeName: "Hydration Hero", challengeProgress: 0.5, challengeProgressText: "1000ml of 2000ml")
                .previewDisplayName("Active Challenge")
        }
        .padding()
        .background(Color.jeuneBGLightColor)
        .previewLayout(.sizeThatFits)
    }
}
#endif
