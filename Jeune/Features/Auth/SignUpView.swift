import SwiftUI

/// Multi-step sign up flow with email, password and personal details stages.
struct SignUpView: View {
    var showLogin: () -> Void
    var complete: () -> Void

    private enum Step {
        case email, password, details
    }

    @State private var step: Step = .email
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var sex: String = "Female"
    @State private var birthDate: Date = Date()

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                Image("logojeune")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)

                switch step {
                case .email:
                    emailStep
                case .password:
                    passwordStep
                case .details:
                    detailsStep
                }

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

    private var emailStep: some View {
        VStack(spacing: 16) {
            PrimaryCTAButton(title: "Continue with Google", background: .black) {
                complete()
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
            TextField("Email", text: $email)
                .textFieldStyle(AuthTextFieldStyle())
            PrimaryCTAButton(title: "Continue",
                             background: email.isEmpty ? .jeuneGrayColor : .jeunePrimaryDarkColor) {
                step = .password
            }
            .disabled(email.isEmpty)
        }
    }

    private var passwordStep: some View {
        VStack(spacing: 16) {
            SecureField("Create Password", text: $password)
                .textFieldStyle(AuthTextFieldStyle())
            PrimaryCTAButton(title: "Continue",
                             background: password.isEmpty ? .jeuneGrayColor : .jeunePrimaryDarkColor) {
                step = .details
            }
            .disabled(password.isEmpty)
        }
    }

    private var detailsStep: some View {
        ScrollView {
            VStack(spacing: 16) {
                TextField("First Name", text: $firstName)
                    .textFieldStyle(AuthTextFieldStyle())
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(AuthTextFieldStyle())
                Picker("Sex", selection: $sex) {
                    Text("Female").tag("Female")
                    Text("Male").tag("Male")
                    Text("Other").tag("Other")
                }
                .pickerStyle(SegmentedPickerStyle())
                DatePicker("Birth Date", selection: $birthDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                PrimaryCTAButton(title: "Finish", background: .jeunePrimaryDarkColor) {
                    complete()
                }
            }
        }
    }
}

#Preview {
    SignUpView(showLogin: {}, complete: {})
        .environmentObject(AppState())
}
