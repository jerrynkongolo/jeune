import SwiftUI

/// Simple sign up screen with email and password fields.
struct SignUpView: View {
    var showLogin: () -> Void
    var complete: () -> Void

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirm: String = ""

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
                    SecureField("Confirm Password", text: $confirm)
                        .textFieldStyle(.roundedBorder)
                }
                PrimaryButton(title: "Sign Up", action: complete)
                Spacer()
                Button(action: showLogin) {
                    Text("Already have an account? Log In")
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
    SignUpView(showLogin: {}, complete: {})
        .environmentObject(AppState())
}
