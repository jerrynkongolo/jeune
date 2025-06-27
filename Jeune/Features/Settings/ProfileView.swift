import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    profileHeader
                    personalInfoSection
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .background(Color.jeuneCanvasColor.ignoresSafeArea())
            .navigationTitle("My Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var profileHeader: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .foregroundColor(.jeuneGrayColor)
                .background(Circle().fill(Color.jeuneGrayColor.opacity(0.2)))
                .clipShape(Circle())
            Text("Username")
                .font(.title.weight(.bold))
        }
        .padding(.vertical, 24)
    }

    private var personalInfoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeaderView(title: "Personal Information")
            VStack(spacing: 0) {
                InfoRow(title: "Name", value: "Jerry Nkongolo")
                Divider().background(Color.jeuneGrayColor.opacity(0.15))
                InfoRow(title: "Email", value: "jerry.nkongolo@example.com")
                Divider().background(Color.jeuneGrayColor.opacity(0.15))
                InfoRow(title: "Birthday", value: "June 2, 1990")
                Divider().background(Color.jeuneGrayColor.opacity(0.15))
                InfoRow(title: "Sex", value: "Male")
            }
            .jeuneCard()
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.jeuneGrayColor)
        }
        .padding()
    }
}

#Preview {
    ProfileView()
}
