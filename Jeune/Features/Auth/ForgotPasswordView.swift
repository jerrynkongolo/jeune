import SwiftUI

/// Screen for requesting a password reset email.
struct ForgotPasswordView: View {
    var backAction: () -> Void

    @State private var email: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                Image("logojeune")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                PrimaryButton(title: "Send Reset Link", action: backAction)
                Spacer()
                Button(action: backAction) {
                    Text("Back to Login")
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
    ForgotPasswordView(backAction: {})
        .environmentObject(AppState())
}
