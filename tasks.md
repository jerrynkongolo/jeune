# JEUNE · HOME SCREEN — REV 2  (visual corrections only)
# Paste this entire spec into Codex and ask it to rebuild the UI.

──────────────────────────────────────────────────────────────
0 ▸ COLOUR TWEAKS  (replace previous tokens)

• Deep-cherry accent  = #931536      # darker & richer than before
• Success green       = #34C759      # unchanged
• Light success tint  = #34C759 @ 8 % opacity      # for streak badge bg
• Neutral ring track  = #D8D8DB      # slightly darker to lift contrast
• Toolbar circle bg   = #EFEFF1      # very light grey, 100 % opaque

──────────────────────────────────────────────────────────────
1 ▸ TOOLBAR (safe-area top)

LEFT – **Streak badge**

    • 34 × 34 pt circle  
    • Fill: *Light success tint*  
    • Inside: white SF Symbol “checkmark” **12 pt** (was too large)  
    • Numeric count “3” (caption, **semibold**) to the immediate right, aligned baseline

CENTER – **Logo**

    • Asset “jeuneLogoMark” height **32 pt** (≈ +30 % bigger)  
    • Keep aspect fit

RIGHT – **Quick-add button**

    • 34 × 34 pt circle, fill = *Toolbar circle bg*  
    • SF Symbol “plus” **title2** weight, colour = *Deep-cherry accent* (NOT white)

──────────────────────────────────────────────────────────────
2 ▸ WEEKDAY MINI-RING STRIP  (immediately beneath toolbar)

• **Vertical order**: weekday labels on top, rings below  
• Weekday label style: caption2 **bold**, secondary colour  
• Mini-ring diameter **26 pt**  
• Stroke width **6 pt** (visibly thicker)  
• Spacing between cells: **16 pt**  
• Progress colour logic unchanged (accent → success)

──────────────────────────────────────────────────────────────
3 ▸ FAST TIMER CARD  (big white card)

Card container:

    • Corner radius 24 pt  
    • Shadow: rgba(0,0,0,0.10), y-offset 2 pt, blur 20 pt  ← sharper & deeper  
    • Horizontal outer padding from screen edge: 16 pt  
    • Inner horizontal padding: **16 pt**  (was too wide)  
    • Inner vertical padding: 24 pt

Large ring:

    • Diameter **280 pt**  (slightly larger)  
    • Stroke width **24 pt**  (≈ 2× previous)  
    • Track colour = Neutral ring track  
    • Gradient NOT required; just switch stroke colour to success when progress ≥ 1

Timer digits:

    • Typeface: *SF Pro Rounded*  
    • Size **64 pt**, weight **black**  
    • Positioned dead-centre inside ring (use ZStack)

Sub-caption:

    • “ELAPSED” / “SINCE LAST FAST” lines: caption, **semibold**, secondary colour  
    • Always centred under digits

Stats capsules row:  (visible **only when fasting**)

    • Each capsule:  min height 48 pt, bg #F2F2F5, corner 20 pt  
    • Title label caption2, secondary · Value label subheadline **semibold**  
    • Grid layout: 2 equal columns, 8 pt spacing

Primary CTA:

    • Pill radius 28 pt, height 54 pt  
    • Idle fill colour = Deep-cherry accent · Running fill = Success green  
    • Label headline **semibold**, white

──────────────────────────────────────────────────────────────
4 ▸ CHALLENGES CARD

• Same shadow & corner spec as main card  
• Tighten horizontal padding inside card to **20 pt**  
• “SEE ALL” label weight = **semibold** (was bold)  
• Placeholder row height **76 pt** to balance new padding

──────────────────────────────────────────────────────────────
5 ▸ SPACING CHECKLIST

• Vertical gap between toolbar and weekday strip: 12 pt  
• Gap between weekday strip and main card: 20 pt  
• Gap between main card and challenges card: 24 pt  
• ScrollView bottom inset: safe-area only (no extra padding)

──────────────────────────────────────────────────────────────
6 ▸ COMPONENT LIST FOR CODEX TO GENERATE / UPDATE

✓ StreakBadgeView  (new sizes & colours)  
✓ ToolbarPlusButtonView  (grey circle + cherry plus)  
✓ MiniRingView  (26 pt, stroke 6 pt, label on top)  
✓ FastTimerCardView  (ring 280 pt/24 pt, new padding, SF Rounded 64 pt)  
✓ ChallengeCardView  (padding tweak)  
✓ Updated colour assets for new Deep-cherry & Light-success-tint

**No timers, data models, or business logic need to change in this rev.**

──────────────────────────────────────────────────────────────
# END OF UPDATED DESIGN SPEC  –  hand to Codex