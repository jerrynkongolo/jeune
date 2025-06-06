import SwiftUI

/// Basic settings screen presented from the Me tab.
struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var weightUnit: WeightUnit = .kilograms
    @State private var darkMode = false
    @State private var notifications = false
    @State private var emails = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header
                Divider()
                ScrollView {
                    VStack(spacing: 32) {
                        preferencesSection
                        accountSection
                        communitySection
                    }
                    .padding()
                }
                .background(Color.jeuneCanvasColor)
            }
        }
    }

    private var header: some View {
        HStack(spacing: 0) {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.jeuneDarkGray)
            }
            Spacer()
        }
        .overlay(
            Text("Settings")
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.black)
        )
        .padding(.trailing)
        .padding(.vertical)
    }

    private var preferencesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Preferences")
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.jeuneNearBlack)

            VStack(spacing: 0) {
                SettingRow(title: "Timer Direction") {
                    Image(systemName: "chevron.right")
                        .fontWeight(.bold)
                        .foregroundColor(.jeuneGrayColor)
                }
                Divider().background(Color.jeuneGrayColor.opacity(0.15))
                SettingRow(title: "Weight Unit") {
                    Picker("Weight Unit", selection: $weightUnit) {
                        ForEach(WeightUnit.allCases) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 120)
                }
                Divider().background(Color.jeuneGrayColor.opacity(0.15))
                Toggle("Dark Mode", isOn: $darkMode)
                    .toggleStyle(SwitchToggleStyle(tint: .jeunePrimaryDarkColor))

                    .padding(.vertical, 12)

                    .padding(.horizontal, 4)
                Divider().background(Color.jeuneGrayColor.opacity(0.15))
                Toggle("Notifications", isOn: $notifications)
                    .toggleStyle(SwitchToggleStyle(tint: .jeunePrimaryDarkColor))

                    .padding(.vertical, 12)

                    .padding(.horizontal, 4)
                Divider().background(Color.jeuneGrayColor.opacity(0.15))
                NavigationLink(destination: Text("Emails")) {
                    SettingRow(title: "Emails") {
                        Image(systemName: "chevron.right")
                            .fontWeight(.bold)
                            .foregroundColor(.jeuneGrayColor)
                    }
                }
            }

            .jeuneCard()

        }
    }

    private var accountSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Account")
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.jeuneNearBlack)

            VStack(spacing: 0) {
                SettingRow(title: "Profile") {
                    Image(systemName: "chevron.right")
                        .fontWeight(.bold)
                        .foregroundColor(.jeuneGrayColor)
                }
                Divider().background(Color.jeuneGrayColor.opacity(0.15))
                SettingRow(title: "Subscription") {
                    Image(systemName: "chevron.right")
                        .fontWeight(.bold)
                        .foregroundColor(.jeuneGrayColor)
                }
            }

            .jeuneCard()

        }
    }

    private var communitySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Community")
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.jeuneNearBlack)

            VStack(spacing: 0) {
                SettingRow(title: "Forums") {
                    Image(systemName: "chevron.right")
                        .fontWeight(.bold)
                        .foregroundColor(.jeuneGrayColor)
                }
            }

            .jeuneCard()

        }
    }
}

private enum WeightUnit: String, CaseIterable, Identifiable {
    case kilograms = "kg"
    case pounds = "lb"

    var id: String { rawValue }
}

#Preview {
    SettingsView()
}
