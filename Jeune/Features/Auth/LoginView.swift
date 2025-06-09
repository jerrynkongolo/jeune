import SwiftUI

/// Simple login screen with email/password fields and social sign in.
struct LoginView: View {
    var showSignUp: () -> Void
    var showForgot: () -> Void
    var complete: () -> Void

    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                Image("logojeune")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .textFieldStyle(AuthTextFieldStyle())
                    SecureField("Password", text: $password)
                        .textFieldStyle(AuthTextFieldStyle())
                }
                PrimaryCTAButton(title: "Log In", background: .jeunePrimaryDarkColor) {
                    complete()
                }
                Button(action: showForgot) {
                    Text("Forgot password?")
                        .font(.footnote)
                        .foregroundColor(.jeunePrimaryDarkColor)
                }
                HStack {
                    Rectangle()
                        .fill(Color.jeuneGrayColor.opacity(0.4))
                        .frame(height: 1)
                    Text("OR")
                        .font(.caption)
                        .foregroundColor(.jeuneGrayColor)
                    Rectangle()
                        .fill(Color.jeuneGrayColor.opacity(0.4))
                        .frame(height: 1)
                }
                PrimaryCTAButton(title: "Continue with Google", background: .black) {
                    complete()
                }
                Spacer()
                Button(action: showSignUp) {
                    Text("Don't have an account? Sign Up")
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.jeunePrimaryDarkColor)
                }
            }
            .padding()
            .background(Color.jeuneCanvasColor.ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LoginView(showSignUp: {}, showForgot: {}, complete: {})
        .environmentObject(AppState())
}
