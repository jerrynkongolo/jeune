import SwiftUI

/// Flow managing the authentication screens.
struct AuthenticationFlow: View {
    @EnvironmentObject var appState: AppState
    @State private var screen: Screen

    init(startScreen: Screen = .login) {
        _screen = State(initialValue: startScreen)
    }

    enum Screen {
        case login
        case signUp
        case forgotPassword
    }

    var body: some View {
        switch screen {
        case .login:
            LoginView(showSignUp: { screen = .signUp },
                      showForgot: { screen = .forgotPassword },
                      complete: { appState.isAuthenticated = true })
        case .signUp:
            SignUpView(showLogin: { screen = .login },
                       complete: { appState.isAuthenticated = true })
        case .forgotPassword:
            ForgotPasswordView(backAction: { screen = .login })
        }
    }
}

#Preview {
    AuthenticationFlow().environmentObject(AppState())
}
