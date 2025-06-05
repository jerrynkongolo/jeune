// EnvironmentValues+SafeAreaInsets.swift
import SwiftUI


private struct JeuneSafeAreaInsetsKey: EnvironmentKey {

    static var defaultValue: EdgeInsets {
#if os(iOS)
        let insets = UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow?.safeAreaInsets }
            .first ?? .zero
        return EdgeInsets(top: insets.top, leading: insets.left, bottom: insets.bottom, trailing: insets.right)
#else
        return EdgeInsets()
#endif
    }
}

extension EnvironmentValues {

    var jeuneSafeAreaInsets: EdgeInsets {
        get { self[JeuneSafeAreaInsetsKey.self] }
        set { self[JeuneSafeAreaInsetsKey.self] = newValue }

    }
}
