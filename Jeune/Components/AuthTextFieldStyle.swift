import SwiftUI

/// Text field style used for authentication screens with larger height and subtle shadow.
struct AuthTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 16)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            )
    }
}

#Preview {
    TextField("Email", text: .constant(""))
        .textFieldStyle(AuthTextFieldStyle())
        .padding()
        .previewLayout(.sizeThatFits)
}
