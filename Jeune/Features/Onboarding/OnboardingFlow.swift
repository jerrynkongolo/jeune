import SwiftUI

/// Single page welcome screen shown on first launch.
struct OnboardingFlow: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image("logojeune")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .padding(.bottom, 20)

            Text("Start your journey with Jeune today")
                .font(.jeuneLargeTitle)
                .multilineTextAlignment(.center)
                .foregroundColor(.jeuneNearBlack)
                .padding(.horizontal)

            Text("Build a healthy lifestyle that still lets you enjoy your life.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.jeuneGrayColor)
                .padding(.horizontal)

            PrimaryCTAButton(title: "Sign in with Google", background: .black) {
                appState.isAuthenticated = true
                appState.onboardingCompleted = true
            }
            PrimaryCTAButton(title: "Other Sign Up Options",
                             background: .jeuneGrayColor,
                             foreground: .jeuneNearBlack) {
                appState.authStartScreen = .signUp
                appState.onboardingCompleted = true
            }
            Button(action: {
                appState.authStartScreen = .login
                appState.onboardingCompleted = true
            }) {
                Text("Already have an account?")
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.jeunePrimaryDarkColor)
            }
            Spacer()
        }
        .padding()
        .background(Color.jeuneCanvasColor.ignoresSafeArea())
    }
}

#Preview {
    OnboardingFlow().environmentObject(AppState())
}
