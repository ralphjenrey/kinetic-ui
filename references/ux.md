# UX patterns

**Label preference:** Use text-only buttons, links, navigation, and CTAs. Omit decorative arrows, icons, circled glyphs, and crosses beside text, including “Next”, “Previous”, and “Close”. Remove their wrappers and spacing. This overrides the historical icon recipes below; preserve accessible functional controls and focus states.


Before designing a new page, follow the project-brief questions in SKILL.md: ask for purpose/audience, identity/content, theme/colors, and motion preferences that are not already known. Wait for answers unless the user delegates the choices. Adapt this reference’s portfolio structure and orange/black examples to the agreed brief; do not impose them on a business or engineer portfolio.

Use the larger typography defaults in SKILL.md and tokens.css: 18px/500 body (17px mobile), 15px/600 navigation, 13px/600 labels, and 19px/600 project titles. Apply these instead of historical smaller type sizes in the examples below.

Extracted from the live site's behavior (homepage app, AI Session page, About, Support,
Thoughts, and the prompt-builder tools). Visual specs live in `components.md`; this file
covers how things behave, flow, and speak.

## Contents
1. UX character
2. Information architecture and navigation
3. Homepage: category filter and project canvas
4. Floating canvas physics (constants)
5. Project detail overlay and the booking modal
6. Custom cursor
7. Offer / booking page pattern
8. Tool-page pattern (live builder)
9. Feedback, states, and empty states
10. Loading and performance behavior
11. Accessibility behavior
12. Responsive behavior
13. Microcopy and voice
14. UX checklist

Reference code: `interactions.js` (seeded layout + physics + cursor), reimplemented cleanly with the site's constants.

---

## 1. UX character

- **Exploratory first, informational second.** The homepage is a canvas to wander, not a
  menu. Detail is one click away, never forced.
- **One clear next step per page.** Every page ends in a single conversion path
  (book a session / support / back to portfolio), shown as the orange `↗` link or the one solid pill.
- **Quiet chrome, loud content.** Navigation is small, muted, and hairlined; the work and the headline carry the weight.
- **Progressive enhancement.** Native `<details>`, `<dialog>`, links and forms work with no JS;
  motion, cursor, and physics layer on top and switch off for touch and reduced-motion.
- **Personal, direct, human.** First-person, short sentences, plain language, a little humor.

## 2. Information architecture and navigation

Site map: Portfolio (home) · About · Thoughts (articles, with an index) · Projects
(1-on-1 AI Session, AI Lunch & Learn, Video Prompt Builder, Banner Prompt Builder) · Stack ·
Support · Privacy · Terms.

Navigation layers, each with one job:

| Layer | Where | Behavior |
|---|---|---|
| Shared header | Every inner page, 48px | Name + orange dot (home link) · About · Thoughts · **Projects ▾** dropdown · Stack · orange **Book a session ↗**. Under 720px: all of it collapses into one "Menu" pill disclosure. |
| Explore ↗ | Hero and page footers | Native `<details>`; panel titled "MORE FROM …" lists *every* page with `→`. Closes on Escape (focus returns to the summary) and outside click. |
| Category nav | Homepage only | Filters the canvas (see §3). Desktop: top tabs. Mobile: fixed bottom pill. |
| Back link | Article/support pages | "← Back to Thoughts", 44px tall, muted, top-left above the eyebrow. |
| Back to top ↑ | Footers | Right-aligned in footer. |
| Credit | Tool pages | "by Name" link under the title ties each tool back to the portfolio. |

Rules:
- Same page list in header, Explore, and footer; keep order identical everywhere.
- Primary conversion link is always orange with `↗` and sits in the header's far right.
- External links open in a new tab and say so for screen readers: `(opens in a new tab)`.
- Marketing-style pages link out; articles link to the next two reads in a 2-card "Next" block.
- Page identity strip: a small `by Name` credit on every tool so it still reads as part of one brand.

## 3. Homepage: category filter and project canvas

Layout: identity column (portrait, name, tagline, actions, location) + canvas of thumbnails,
with the category nav on top. Categories: **All · Web · Videos · Brands · Testimonials**.

Behavior:
1. Clicking a category that isn't active starts a **fade swap**: set the canvas stage to hidden
   (`opacity:0; pointer-events:none; inert`), wait **280 ms**, switch the category, then on the next animation frame fade back in
   (opacity transition .28s). Cancel pending timers/frames if the user clicks again quickly, and on unmount.
2. The active tab gets `aria-current="true"`, orange text, and an animated underline.
3. **All** shows a *subset* sized to the viewport (`max(8, floor(area / 40000))` items, shuffled with a seeded RNG)
   so the canvas never feels crowded. A specific category shows everything in it, at larger tile sizes.
4. When a category is selected, a few **ghost tiles** from the other categories fade in behind (3 on desktop, 1 on mobile)
   at 8% opacity, grayscale, blurred and slowly drifting. They hint that there is more elsewhere and are `aria-hidden`.
5. The layout seed is random per page load, so each visit arranges tiles differently, but it is stable
   while the user filters back and forth in that visit.
6. **Testimonials** swap the canvas for a vertical auto-scrolling wall (see `components.md` §8).
   Columns scroll at 136s, 154s, 172s; alternating columns reverse; the wall pauses on hover/focus-within or while a video plays;
   content is duplicated for a seamless loop, and the duplicate half is `aria-hidden` + `inert`.
7. Opening a project: tiles are `<button>`s (Enter/Space open, `aria-label="Title — open project details"`).
   Article-type items navigate to their page instead of opening an overlay.
8. Hover/focus a tile: show the hover card (see §4) and dim siblings. Keyboard focus triggers the same state as hover.
9. Footer area under the canvas holds a slim **tools marquee** ("Tools I use"); on mobile it moves into the hero footer.

Mobile (≤860px or touch): no physics, no hover card, no cursor. Tiles become a stacked responsive grid
(`auto-fit, minmax(min(100%,260px),1fr)`) with a persistent title + one-line description over a bottom gradient.
Staggered enter delay `index * .04s` (desktop `.07s`).

## 4. Floating canvas physics (constants)

Desktop, `(hover:hover) and (pointer:fine)`, motion allowed. One `requestAnimationFrame` loop
for all tiles, paused when `document.hidden` (resume on `visibilitychange`).

| Constant | Value | Meaning |
|---|---|---|
| Idle drift | `x = sin(t·speed + phaseX)·ampX`, `y = cos(t·speed·.9 + phaseY)·ampY` | each tile has random `speed .35–.85`, `ampX 5–10px`, `ampY 5–12px`, random phases |
| Pointer influence radius | **135 px** | tiles inside it are repelled and brightened |
| Push strength | **16 px** × (1 − d/135) | away from the pointer |
| Spring | **.1** | `v = (v + (target − pos)·.1) · .78` |
| Damping | **.78** | gives a soft, slightly floaty settle |
| `--proximity` | `1 − d/135` (1 when hovered) | CSS uses it for brightness `1 + proximity·.22` |
| Hovered tile | drift stops (target 0) | so it holds still under the cursor and scales to 1.16 |
| Hover card offset | 35 px from tile edge | appears on the right if more than 255px of room, otherwise the left; top is clamped to `[0, height−90]` |

Layout algorithm: seeded RNG → assign tiles to jittered grid cells (cell size × 30% jitter) → 220 relaxation
iterations pushing overlapping rectangles apart (min gap 22px desktop, 14px mobile, 10px for ghosts), plus pushing out of an
**exclusion band at the top** (nav height 86 + 16 so tiles never sit under the category nav). 24px padding.
Aspect ratios by category: web .625, videos .5625 (9:16-ish vertical), brands 1, testimonials 1, thoughts .6875.
Tile widths: single category 143–209px, All `clamp(74–112) … clamp(138–190)` scaled by available area.

Reduced motion: transforms reset to 0, no drift, no proximity push, enter animations shortened to .15s.

## 5. Project detail overlay and booking modal

- Project detail opens in a **lazy-loaded lightbox** with `siblings` (all projects in the same category) so the
  user can step through without closing. Data per project: title, one-line description, tags, long overview
  (first line is a punchy tagline), objectives (3), responsibilities (3), URL, screenshots/video, optional technologies.
- While any overlay is open, the page behind gets `aria-hidden="true"` and `inert` so focus stays inside.
- Overlays and heavy visuals are code-split (`lazy`), loaded only when needed. Fallback is `null` (no spinner flash).
- **Discovery call** is a modal opened from a small ghost pill with a "15" badge and an accessible label
  ("Book a 15-minute discovery call") next to the solid "Let's talk"-style pill. Short, low-commitment first step.
- Video: show a poster with a big accent play button; **click-to-load** the iframe (autoplay on click, controls hidden for shorts, `playsinline`, `rel=0`).
  The poster darkens (`brightness(.85)`) and scales 1.02 on hover; the play button scales 1.08.
  Only one testimonial video plays at a time; a small "×" stop button sits top-right of the playing frame.

## 6. Custom cursor

Use a smooth, delayed cursor follower when the user enables cursor effects. Keep mobile and reduced-motion fallbacks: native cursor, no custom follower, and no cursor-dependent functionality. See SKILL.md for the default behavior.

Desktop pointer-fine only; adds `body.custom-cursor-active` (native cursor hidden). If JS fails or the media
query doesn't match, the native cursor stays.

- 7px ink **dot** follows the pointer tightly (smoothing .6); a **ring** follows with a spring (stiffness .16, damping .72).
- Ring states are chosen from `data-cursor` on the nearest ancestor: `default` (40px, orange fill, small), `view` (76px, solid orange with "View" label in black), `close` (52px dark glass with "Close"), `circle` (40px).
- Over any other interactive element (`a, button, [role=button], input, select, textarea, label`) the ring **morphs to wrap the element**: its bounding box + 20px, 10px offset, 12px radius (or full circle if the element is square-ish) with a tinted orange fill; the dot shrinks to 0.
- Pointer down adds `.is-pressed` (slight dim). Hidden when the pointer leaves the window.

## 7. Offer / booking page pattern (AI Session)

Single-screen, no-scroll desktop layout (`100svh` grid: header row · main · offer strip · footer). Structure:

1. Eyebrow line with a name and a rule: `✦ ──── Title · by Name`.
2. Huge stacked headline with one script word ("Let's make *AI click.*").
3. One-paragraph promise in plain, warm language.
4. "What we can get into": a **numbered list** (01–03) with `↗` links to deeper pages, hairline-separated.
5. Offer strip: person's name + role, **price**, what's included (1-hour call + 30-day direct chat), channel choice,
   the **guarantee** ("confirmed within 24 hours or full refund"), and the primary button ("Book my session ↗"), plus a payment trust line.
6. Preparation note ("Before the call: …").
7. FAQ "Questions +" with 3 short, reassuring answers (Do I need to code? What is X? What if none of my times work?).
8. Booking is a second page (`/book`) with a form; payment is handled by a hosted provider, scheduling happens *after* checkout ("pick your 3 best times").

Principles: price visible up front; remove risk with a guarantee; first objection ("do I need to code?") answered in the FAQ; one button.

## 8. Tool-page pattern (live builder)

Used by the Banner and Video prompt builders. A reusable template for any "configure → get output" tool.

- **Two panes**: scrolling steps (left), sticky live output (right, 440px). Output updates on every input event.
- **Numbered steps** `01 Samples → 02 Your design → 03 Art direction → 04 Fine-tune` with a sticky chip bar for jumping.
- **Start from an example**: a gallery of presets with thumbnails; selecting one fills sensible defaults. "Build your own direction ↗" for a blank start (scrolls smoothly to step 02).
- **Search + filter chips** with result count in caps ("6 DIRECTIONS"). Press **`/`** anywhere (outside inputs) to focus search; **Enter** in search picks the first result. Search normalizes case, spaces, hyphens, and a leading `/` command.
- **Progressive disclosure**: art-direction controls are grouped `<details>`; "Expand all / Collapse all" toggle (`aria-expanded`), and "Restore sample settings" resets overrides without losing the brief; a count of overrides is shown.
- **Persistence**: state saved to `localStorage` on every change (versioned key like `tool-name:v1`), restored on load with validation (ignore unknown preset ids / option values). Wrap in try/catch; if storage is unavailable show "Browser storage unavailable. Copy your prompt before leaving."
- **Output actions**: primary **Copy** (disabled until a selection exists), secondary `.md` download (Blob + temporary anchor), **Reset** (clears everything, returns filters to All, toasts "Builder reset"). Word count shown live ("124 WORDS").
- **Sample viewer**: native `<dialog>.showModal()` with a close button; "View selected sample ↗" disabled when there is nothing to view.
- **Mobile**: sidebar stacks below content; a fixed full-width orange "jump to prompt" bar floats at the bottom.
- Helper copy under the actions says what to do next with the output ("Paste into ChatGPT. Attach your product image…").
- Footer line: "Made for … Built by Name ↗".

## 9. Feedback, states, and empty states

- **Toast**: bottom-center, `role="status"`, shows 2.8s then hides; new toast cancels the previous timer. Copy: confirm + next step ("Copied. Take it to ChatGPT.").
- **Copy fallback**: `navigator.clipboard.writeText`; on failure create a hidden `<textarea>`, `execCommand('copy')`, and report "Prompt copied." or "Copy unavailable. Select and copy the prompt manually."
- **Disabled** primary buttons use `opacity:.4; cursor:default`; hide rather than disable secondary actions with nothing to do.
- **Selected state**: orange border + 3px soft ring + `✓` replacing the `↗` glyph; `aria-pressed` reflects it.
- **Empty search**: friendly one-liner with example terms ("No samples found. Try “type”, “product”, or “8bit”.").
- **Pre-selection placeholders** in the output pane explain the next step ("SELECT A SAMPLE TO BEGIN", "A little inspiration goes a long way.").
- **Live regions**: output summary uses `aria-live="polite"`.
- **Page transitions**: route-level `lazy` chunks show a blank `div[role=status][aria-label="Loading …"]` filled with that page's background color, so there is no white flash between dark pages.
- **Hover** always has a keyboard-focus twin; **active** states use color + underline, never color alone.

## 10. Loading and performance behavior

- Prerender pages and hydrate; fonts preloaded (`<link rel=preload as=font type=font/woff2>`) with `font-display:swap`.
- First tile image: `loading="eager" fetchpriority="high"`; the rest `lazy`. Provide `srcset` (360w/720w) and `sizes`, set `width`/`height` to avoid layout shift. Ghost images `decoding="async"`.
- Heavy visuals (reveal canvas behind the portrait, lightbox, booking modal) are **lazy chunks** and the reveal canvas only loads for desktop pointer-fine.
- Analytics (tag manager) deferred until first interaction or ~12 seconds after load.
- rAF loops pause when the tab is hidden; resize handled with `ResizeObserver`.
- Visitor counter is progressive: element hidden until a value loads.

## 11. Accessibility behavior

- Skip link on article/support pages; appears on focus (orange background).
- Landmarks and labels: `<nav aria-label="Portfolio categories">`, `"Site"`, `"Builder steps"`, explore panel `aria-label`.
- `aria-current` on active nav, `aria-pressed` on toggle chips/cards, `aria-expanded` on disclosure buttons.
- Background `inert` while overlays are open; duplicated marquee/wall content `inert` + `aria-hidden`.
- Visually-hidden labels where the UI shows an icon only (discovery pill), `.sr` class using `clip-path:inset(50%)`.
- Tap targets ≥ 44px (links in footers and nav get `min-height:44px`).
- External links announce "(opens in a new tab)".
- `prefers-reduced-motion` disables marquees, drift, parallax-style physics, cursor, and shortens fades.
- Text contrast: on light surfaces use the darker orange text color (`#b54500`) for small text.

### User-supplied lists

When the user provides brands, skills, tools, or languages, show the muted horizontal strip specified in SKILL.md and components.md §13. Keep its meaning accurate, preserve the supplied entries, and expose a single accessible original list. Continuous autoplay needs a text-only Pause/Resume control as well as hover/focus pausing. Reduced-motion layouts show all items statically; mobile must retain access to every item.

### Smooth scrolling and parallax

When selected in the motion brief, retain smooth desktop scroll easing and add layered scroll-linked offsets for hero artwork, project tiles, and headings. Read `scroll-motion.md` for implementation and verification. Entry reveals alone are not parallax. Compose offsets with existing animation transforms, bound movement to avoid overlap, and preserve keyboard/anchor/dialog behavior. Mobile, coarse pointers, and reduced-motion users get native scrolling and static layers.

## 12. Responsive behavior

| Width | Change |
|---|---|
| ≤1200 | Tighter category nav: smaller font, smaller badge text; contact pills compress |
| ≤1100 | Tool sidebar 440 → 360px; tool page padding 36 → 22px |
| ≤1040 | Testimonial wall 3 → 2 columns |
| ≤860 | **Main switch**: hero stacks; portrait shrinks left with a horizontal fade; category nav becomes a fixed bottom pill (blurred, 999px radius, safe-area padding); social rail moves to top-right row; canvas becomes a stacked grid; no cursor/physics/hover card |
| ≤800 | Tool page stacks; prompt panel moves below with a fixed "jump to prompt" bar |
| ≤720 | Shared header collapses to a "Menu" pill; article TOC moves above content; list rows become two-line; footers wrap |
| ≤600/560/520 | Further type/gap shrink in hero and nav; Explore panel becomes full-width minus margins |

Rules: hide secondary copy before shrinking primary copy (the hero intro disappears on mobile, headline stays); keep tap targets large; keep primary CTA reachable in the bottom thumb zone.

## 13. Microcopy and voice

Tone: warm, direct, first person, short sentences, light humor, occasional local flavor. Say what it is, who it's for, what happens next.

- Headlines: noun phrases and verbs, punchy: "Designer. Creator. Problem Solver." "Let's make AI click."
- Labels: tiny uppercase eyebrows ("MORE FROM ELRON", "THANKS FOR THE SUPPORT", "LET'S TALK").
- CTAs: verb + object + `↗`: "Book my AI Session ↗", "Copy ChatGPT prompt ↗", "Explore ↗".
- Reassurance beats features: "No. If you can write a message, you can follow." / "Full refund if I don't confirm within 24 hours."
- Empty/error states suggest a next action; success toasts name the next step.
- Support/tip prompt is gentle and personal ("If my work helped you…").
- Avoid corporate filler ("leverage", "solutions", "seamless"). Prefer concrete numbers (price, hours, days).

## 14. UX checklist

- [ ] Every page has one primary next step, and it is visually unique (orange `↗` or the single solid pill)
- [ ] Same nav list everywhere, with an Explore-style "all pages" menu reachable from any page
- [ ] Interactions have hover **and** keyboard-focus equivalents; all clickable things are real `<button>`/`<a>`
- [ ] Filters fade-swap (≈280ms), never hard-jump, and use `aria-current`/`aria-pressed`
- [ ] Overlays make the background `inert`, close with Esc/outside click, and restore focus
- [ ] Touch and reduced-motion get a calm, static layout, not a broken desktop one
- [ ] Tools persist state (try/catch), show live output, give a clear Copy/Reset, and toast with the next step
- [ ] Empty states and placeholders tell the user what to do next
- [ ] Heavy visuals/modals are lazy-loaded; first image eager, the rest lazy; fonts preloaded
- [ ] Copy is first-person, concrete, and free of jargon
