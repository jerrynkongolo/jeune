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
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                PrimaryButton(title: "Log In", action: complete)
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
                Button(action: complete) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Continue with Google")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.jeuneGrayColor.opacity(0.3), lineWidth: 1)
                    )
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
