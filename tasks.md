

1 · Design tokens – Jeune color palette

Token	Purpose	Light HEX	Dark HEX	Notes
jeunePrimary	Brand / CTAs, selected tab, pills	#C23050	#AA1E44	Reddish-orange / berry tone identical to Zero’s signature accent  ￼
jeuneSuccess	Success state, completed fast ring, “End Fast” active	#34C759	#34C759	System green analogue  ￼
jeuneGray	Secondary text	#8E8E93	#8E8E93	Matches iOS secondary label colour  ￼
jeuneBGLight	Default light background	#FFFFFF	–	
jeuneBGDark	Default dark background	#121212	#121212	Used heavily in Zero onboarding screens  ￼
Category hues*	Data visualisation (calendar rings, charts)	see list →	same	Nutrition = #FF9500, Activity = #0A84FF, Restoration = #AF52DE, Weight = #30D158, Sleep = #64D2FF  ￼

*You can refine category colours later; these follow Apple system swatches for maximum accessibility.

SwiftUI snippet for Colour extension

// Color+Jeune.swift
import SwiftUI

extension Color {
    static let jeunePrimary      = Color("jeunePrimary")
    static let jeunePrimaryDark  = Color("jeunePrimaryDark")
    static let jeuneSuccess      = Color("jeuneSuccess")
    static let jeuneGray         = Color("jeuneGray")
    static let jeuneBGLight      = Color("jeuneBGLight")
    static let jeuneBGDark       = Color("jeuneBGDark")

    // Category colours
    static let jeuneNutrition    = Color("jeuneNutrition")
    static let jeuneActivity     = Color("jeuneActivity")
    static let jeuneRestoration  = Color("jeuneRestoration")
    static let jeuneWeight       = Color("jeuneWeight")
    static let jeuneSleep        = Color("jeuneSleep")
}

Codex prompt: “Create colour assets in Assets.xcassets with the above names, each containing light & dark variants using the provided HEX codes. Then generate the Color+Jeune.swift file.”

⸻

2 · Typography choices
	•	System font SF Pro throughout – Display cut for giant numbers (timer), Text cut for body.
	•	Hierarchy:
	•	Large Title (28 pt, Bold) – screen headers, e.g. “Today”, “Explore”
	•	Title 2 (22 pt, Semibold) – card headings, modal titles
	•	Body (17 pt, Regular) – paragraphs
	•	Caption (13 pt, Uppercase, 0.5 pt tracking) – meta labels (“ARTICLE”, days-of-week)
	•	Timer digits – 64 pt, Ultra-bold  ￼

Codex can expose these as a Font+Jeune.swift helper if you wish.

⸻

3 · Project & folder structure (MVVM-ish)

Jeune/
│
├─ JeuneApp.swift          // entry point, sets up RootTabView
├─ Resources/
│   ├─ Assets.xcassets      // colours, icons, illustrations
│   └─ Localization/
│
├─ Core/
│   ├─ Models/             // FastSession, UserProfile …
│   ├─ Services/           // HealthKitService, SubscriptionService
│   └─ Utilities/          // Extensions, Constants
│
├─ Features/
│   ├─ Onboarding/
│   ├─ Paywall/
│   ├─ RootTab/
│   │   ├─ Today/
│   │   ├─ Explore/
│   │   └─ Me/
│   └─ Components/         // FastingRingView, PrimaryButton, SegmentedControl …
│
└─ Packages/               // e.g. SwiftUICharts for graphs

Codex prompt: “Generate the above folder structure and stub each folder with an empty README.md so Xcode keeps them under version control.”

⸻

4 · Starter SwiftUI scaffolding

// JeuneApp.swift
@main
struct JeuneApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(appState)
                .preferredColorScheme(.automatic)
        }
    }
}

// RootTabView.swift
struct RootTabView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem { Label("Today", systemImage: "timer") }

            ExploreView()
                .tabItem { Label("Explore", systemImage: "safari") }

            MeView()
                .tabItem { Label("Me", systemImage: "person") }
        }
        .accentColor(.jeunePrimary)
    }
}

The TodayView should host FastingRingView (a circular progress layer that animates from orange → green on goal completion, mirroring Zero’s behaviour  ￼).

⸻

5 · Next steps after palette & scaffold
	1.	Implement design-system components (buttons, segmented control, pill tags).
	2.	Build static screen layouts for Onboarding, Paywall, Today, Explore, Me – use placeholders for data.
	3.	Hook up dummy view-models to drive timers & charts.
	4.	Later: integrate HealthKit + subscription logic.

⸻

Single-sentence prompt to bootstrap everything

“Using Swift 5.9 & SwiftUI, create a new iOS app called Jeune with the folder structure above, add colour assets and extensions from the provided palette, set SF Pro hierarchy, and stub RootTabView with Today, Explore and Me tabs styled with jeunePrimary accent.”

Feed that to Codex and you’ll have a clean, design-accurate skeleton ready for UI iteration. Good luck building Jeune!