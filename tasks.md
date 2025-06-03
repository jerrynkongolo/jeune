# JEUNE · HOME SCREEN – DESIGN-ONLY SPEC  (no data / logic yet)
# Goal: replicate the two reference screenshots pixel-for-pixel.

──────────────────────────────────────────────────────────────
1 ▸ GLOBAL TOKENS  (add to Assets / constants)

• Canvas-background:  #F7F7F9   (very light warm grey)
• Card-background:    #FFFFFF
• Card-shadow:        10-pt blur, y-offset 1, 5 % black opacity
• Corner radius for all cards & buttons: 24 pt
• Accent colour (CTAs, partial rings, links): #C23050  (deep cherry-red berry)
• Success colour (complete rings & buttons):  #34C759  (iOS system green)
• Neutral ring track: #E1E1E3
• Toolbar icon container: 34 × 34 pt circle
• Large timer ring:  diameter 260 pt · stroke width 12 pt
• Mini weekday rings: diameter 30 pt · stroke width 4 pt
• Primary CTA height: 54 pt · pill shape (corner 28 pt)

──────────────────────────────────────────────────────────────
2 ▸ TOOLBAR LAYOUT (Navigation Bar)

LEFT   = *Streak badge*  
 • Circular background: accent when streak achieved, neutral grey otherwise  
 • White “checkmark” SF Symbol (14 pt, bold) inside  
 • Count label (“0”, “1”, …) next to circle (caption, semibold)

CENTER = Jeune logomark (already in Assets) — 24 pt height, aspect fit

RIGHT  = “+” button  
 • Symbol: SF “plus”, title3 weight  
 • White icon on accent-colour circular 34 × 34 pt background  
 • Taps will open quick-actions later (no logic now)

──────────────────────────────────────────────────────────────
3 ▸ WEEK-AT-A-GLANCE STRIP (under toolbar)

• Horizontal row of 7 identical cells, centred, 20 pt spacing  
• Each cell = VStack:  
   1️⃣ Mini ring (30 pt) showing fasting progress for that weekday  
    • empty = track only  
    • 0 < progress < 1 = accent stroke  
    • progress ≥ 1  = success stroke  
   2️⃣ Weekday label (MON, TUE …) — SF Pro, caption2, secondary colour

──────────────────────────────────────────────────────────────
4 ▸ FAST TIMER CARD  (white card + shadow)

GENERAL FRAME  
• Full-width minus 16 pt horizontal padding on each side  
• Vertical inner padding: 24 pt  
• Corner radius: 24 pt  
• Card shadow spec above

INSIDE LAYOUT (VStack, 24 pt spacing)

A Large ring (260 pt)  
 • Track = neutral grey (#E1E1E3)  
 • Progress stroke colour rule: accent until progress ≥ 1.0, then success  
 • Stroke line-cap round, animates clockwise from top (-90° rotation)

B Ring centre content varies by state:  
 **IDLE**   
  • “SINCE LAST FAST” caption (caps, caption, secondary)  
  • Giant days count (“135 days”) 56 pt, ultra-bold, rounded digits  
  • Link text “EDIT 13H GOAL” caption2, accent colour  
 **RUNNING**   
  • Elapsed timer (e.g. “16:19:46”) 56 pt, ultra-bold, rounded  
  • Sub-caption “ELAPSED (102 %)” caption, secondary

C If state = RUNNING → show a capsule stats row:  
 • Two equal “capsules”, 8 pt space between  
 • Capsule BG #F2F2F7, corner 20 pt  
 • Left: title “STARTED”, value start-date/time  
 • Right: title “16H GOAL”, value goal-time  
 • titles = caption2 secondary | values = subheadline semibold

D Primary CTA button (fills entire card width minus 48 pt)  
 • Idle state label: “Start Fasting”, fill = accent  
 • Running state label: “Break Your Fast”, fill = success  
 • Text: headline, semibold, white  
 • Corner radius 28 pt (pill)

──────────────────────────────────────────────────────────────
5 ▸ CHALLENGES CARD  (static placeholder for now)

• Same card styling as timer card  
• Top HStack:  
 “Challenges” (title3, semibold) … Spacer … “SEE ALL” (caption, bold, accent)  
• Below: single 80 pt-tall rounded-rect placeholder (#F0F0F2)  
  Left icon SF “flame.fill” accent  
  Two-line subtitle “Join challenges to earn achievements” (subheadline, 2 lines)  
  Right chevron SF “chevron.right” accent

──────────────────────────────────────────────────────────────
6 ▸ SPACING / PADDING SUMMARY

• Entire ScrollView content: 24 pt top spacing, 24 pt vertical between sections  
• Horizontal safe-area padding: 16 pt (cards align)  
• No bottom inset handling needed yet

──────────────────────────────────────────────────────────────
7 ▸ COMPONENT & FILE CHECKLIST  (Codex to generate)

✅ Color asset additions (see tokens)  
✅ `RingView` (configurable diameter, progress, colour rules)  
✅ `MiniRingView` (wraps RingView + weekday label)  
✅ `StreakBadgeView`  
✅ `JeuneHomeView` main screen  
✅ `FastTimerCardView` (supports .idle & .running states)  
✅ `PrimaryCTAButton` (pill)  
✅ `ChallengesCardView` (static)  
✅ Simple `HomePreviewProvider` with mock idle/running states

*Do **not** implement Combine timers, HealthKit, or real data persistence yet; placeholders are fine.*

──────────────────────────────────────────────────────────────
# END OF DESIGN SPEC  