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
        HStack {
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
        .padding()
    }

    private var preferencesSection: some View {
        VStack(spacing: 0) {
            sectionHeader("Preferences")
            Divider().background(Color.jeuneGrayColor.opacity(0.3))
            settingRow(title: "Timer Direction") {
                Image(systemName: "chevron.right")
                    .foregroundColor(.jeuneDarkGray)
            }
            Divider().background(Color.jeuneGrayColor.opacity(0.3))
            settingRow(title: "Weight Unit") {
                Picker("Weight Unit", selection: $weightUnit) {
                    ForEach(WeightUnit.allCases) { unit in
                        Text(unit.rawValue).tag(unit)
                    }
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 120)
            }
            Divider().background(Color.jeuneGrayColor.opacity(0.3))
            Toggle("Dark Mode", isOn: $darkMode)
                .toggleStyle(SwitchToggleStyle(tint: .jeunePrimaryDarkColor))
                .padding(.horizontal, 4)
            Divider().background(Color.jeuneGrayColor.opacity(0.3))
            Toggle("Notifications", isOn: $notifications)
                .toggleStyle(SwitchToggleStyle(tint: .jeunePrimaryDarkColor))
                .padding(.horizontal, 4)
            Divider().background(Color.jeuneGrayColor.opacity(0.3))
            NavigationLink(destination: Text("Emails")) {
                settingRow(title: "Emails") {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.jeuneDarkGray)
                }
            }
        }
        .padding()
        .background(Color.jeuneCardColor)
        .cornerRadius(DesignConstants.cornerRadius)
    }

    private var accountSection: some View {
        VStack(spacing: 0) {
            sectionHeader("Account")
            Divider().background(Color.jeuneGrayColor.opacity(0.3))
            settingRow(title: "Profile") {
                Image(systemName: "chevron.right")
                    .foregroundColor(.jeuneDarkGray)
            }
            Divider().background(Color.jeuneGrayColor.opacity(0.3))
            settingRow(title: "Subscription") {
                Image(systemName: "chevron.right")
                    .foregroundColor(.jeuneDarkGray)
            }
        }
        .padding()
        .background(Color.jeuneCardColor)
        .cornerRadius(DesignConstants.cornerRadius)
    }

    private var communitySection: some View {
        VStack(spacing: 0) {
            sectionHeader("Community")
            Divider().background(Color.jeuneGrayColor.opacity(0.3))
            settingRow(title: "Forums") {
                Image(systemName: "chevron.right")
                    .foregroundColor(.jeuneDarkGray)
            }
        }
        .padding()
        .background(Color.jeuneCardColor)
        .cornerRadius(DesignConstants.cornerRadius)
    }

    private func sectionHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.callout.weight(.semibold))
            Spacer()
        }
        .padding(.bottom, 8)
    }

    private func settingRow<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.jeuneNearBlack)
            Spacer()
            content()
        }
        .padding(.vertical, 8)
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
