---
name: kinetic-ui
description: Build UI and UX in the dark, editorial portfolio style of elronnaranja.com — interaction patterns (floating project canvas, fade-swap category filters, custom cursor, lightbox, live tool builders, booking/offer pages) plus the visual system - pure black pages, warm paper-white text, a single orange accent, condensed uppercase Archivo display headlines with an italic serif accent word, hairline dividers, pill and outlined buttons, floating work thumbnails and glassy testimonial cards. Use this skill whenever the user asks for a UI, landing page, portfolio, personal site, dashboard, tool page, article page, or component "in the Elron style", "like elronnaranja.com", "dark orange editorial", or asks for the same navigation, interactions, flows, microcopy or accessibility behavior, or wants to restyle an existing React/Tailwind/HTML/Flutter screen to match this look and feel, even if they only say "use the Elron design system" or "make it match the portfolio".
---

# Elron Naranja UI style

A dark, editorial, confident look: black canvas, warm off-white ink, one orange accent,
big condensed uppercase headlines, and lots of hairlines instead of boxes. It reads as
"designer's portfolio" rather than "SaaS dashboard".

Extracted from the site's own CSS and JavaScript (homepage app, About, thoughts/articles, AI
session, prompt-builder tools). The visual language follows the source site; typography uses the user’s larger, heavier sample-page defaults. It covers
both the **visual system** and the **UX**: navigation, interaction behavior, flows, states,
microcopy, accessibility and performance behavior.

## Ask for the project brief first

Before creating a new page, ask the user for any preferences not already supplied in the conversation. Do not assume that a request to use this skill means a designer portfolio or an orange-on-black theme. Ask one concise, bundled set of questions and wait for the answers before choosing content, layout, or colors:

1. **Purpose and audience:** “What is this site for—a business, software engineer portfolio, designer portfolio, product, or something else? Who should it reach, and what should visitors do?”
2. **Identity and content:** “What name, role or business, services, and projects should it feature?” Ask only for essentials missing from the brief; do not require uploads.
3. **Theme and colors:** “Do you prefer dark, light, or system theme? What main/accent colors should I use? You can give color names, hex codes, or say ‘choose for me’.”
4. **Feel and motion:** “Should it feel minimal, professional, bold, or playful? Do you want the smooth, delayed cursor, floating projects, and smooth scrolling with parallax, or a calmer layout?”

Offer a few concrete choices without forcing them. If the user already answered a question, reuse that answer. For a small edit to an existing site, ask only when a new decision is needed; do not repeat onboarding. If the user explicitly delegates the choices or asks to proceed without questions, select sensible defaults and state them briefly. An unanswered question does not count as choosing the defaults.

Adapt the page to the stated purpose: emphasize experience, technical projects, and contact for an engineer; services, business details, and enquiries for a business; relevant work and process for a designer. Use only supplied or verified claims; clearly label any sample content.

Treat the black/orange palette below as the fallback when the user chooses it or delegates color selection. User-selected theme and brand colors override source-site color prescriptions, including references, examples, and checklists. Update surface, ink, muted text, borders, accent variants, hover/focus states, and cursor colors together through tokens; avoid leftover hardcoded orange. Preserve readable contrast and reduced-motion/touch fallbacks. Keep the larger Archivo typography defaults unless the user requests a different font.

## How to use this skill

0. Complete the preference questions above and retain the answers as the project brief.
1. Read `references/tokens.css` and copy it into the project (or translate the variables to
   Tailwind `theme.extend`, a CSS-in-JS theme, or Flutter `ThemeData`; see "Porting" below).
2. Copy `assets/fonts/` next to the CSS and fix the `@font-face` paths. If fonts can't be
   bundled, load **Archivo** from Google Fonts: display = weight 800 at width 62 (`wdth` axis,
   condensed), text = 500–600 (bundle supports 400–700). Fall back to `Impact` / `system-ui`.
3. Before writing any component, check `references/components.md` for an existing recipe
   (buttons, nav, chips, cards, list rows, article page, tool sidebar, hero, etc.).
4. Before designing any flow, page structure, or interaction, read `references/ux.md`
   (navigation, filtering, overlays, cursor, offer pages, tool pages, states, microcopy,
   accessibility). For the floating canvas, custom cursor or filter fade-swap, start from
   `references/interactions.js` (framework-agnostic, uses the site's real constants).
5. Run both checklists (visual below, UX in `ux.md` §14) before delivering.

## The system in one screen

| Token | Value | Use |
|---|---|---|
| `--bg` | `#000000` | Page background. Pure black, not charcoal. |
| `--bg-raised` | `#0b0b0b` | Menus, panels, sidebars |
| `--ink` | `#f5f0ea` | Primary text. Warm paper white; never `#fff`. |
| `--muted` | `#9a9590` | Body copy, secondary text |
| `--faint` | `#5c5854` | Meta, locations, section labels |
| `--line` | `rgba(245,240,234,.10)` | Every divider and card border |
| `--accent` | `#f47721` | The only color. Arrows, active states, one accent word, primary CTA |
| `--font-display` | Archivo 800 condensed | Headlines, uppercase |
| `--font-text` | Archivo 400–700 | Everything else |
| `--font-script` | Georgia italic | One accent word per headline |

Article pages shift to a warmer black (`#0e0d0c`) with brown-tinted code surfaces
(`#171411`, border `#332a23`, left rule `#9a5b2d`). The AI-session page uses a warm
charcoal `#171815` with film grain. See `components.md` §11 and §14.

## Text-only labels

Use plain text for buttons, links, navigation, headings, and calls to action. Do not add decorative icons, emoji, arrows, chevrons, circled arrows, or crosses beside visible text. Write “Next”, “Previous”, “Explore”, “Close”, and “Back to top” without prefix or suffix symbols. Remove icon wrappers and their reserved spacing, not just the glyph. Use typography, borders, spacing, hover states, and focus rings for affordance. This user preference overrides icon/arrow prescriptions and historical recipes throughout this skill. Retain genuinely necessary standalone controls or semantic status indicators only when they serve a clear function and have accessible names.

## Core rules

Apply the following source-style defaults only where they agree with the user’s project brief and chosen theme.

**Color**
- Black surface, warm-white ink, muted gray body copy. Orange appears in small doses:
  active tab, arrow glyphs, a script accent word, eyebrow labels, the one primary button.
  If orange covers more than ~5% of a screen, remove some.
- Borders and dividers are always the 10% ink hairline. Hover moves a border to orange.
- Depth comes from opacity, dimming, and glows (`0 0 28px -6px accent-dim`), not drop-shadow stacks.
  Panels that float over content get one heavy dark shadow (`0 18px 60px #0008`).

**Typography**
- Headlines: display font, weight 800, **uppercase**, line-height `.95`, letter-spacing `-.01em`,
  `text-wrap:balance`. Sizes are fluid with `clamp()`: page title `clamp(40px,6vw,72px)`,
  index hero `clamp(64px,9vw,110px)`.
- Accent word: wrap one word in `<em>`, set Georgia italic, lowercase, `letter-spacing:-.04em`, orange.
- Eyebrows/labels: 13–16px, 600 weight, **uppercase, `.14em` tracking**.
- Body: 18px at weight 500 with a very airy `line-height:2`, muted color. Reading text on article pages is
  18px/1.9. Lead paragraphs step up to 19–21px.
- Never synthesize a bold display weight; only 800 exists. Don't mix in other families,
  except Poppins for the homepage name line only.

**Layout**
- Generous negative space. Text columns cap at 720–880px. Hero type is huge; body is readable at 18px.
- Structure with hairline rules and grid alignment, not nested boxes. Lists are rows
  separated by lines, with clear text labels.
- Homepage pattern: 40% identity column (B&W portrait fading into black) plus a canvas of
  thumbnails. Mobile stacks it and moves nav to a fixed bottom pill.
- Breakpoints used: `1200`, `1100`, `1040`, `860` (main mobile switch), `720`, `600`, `560`, `520`.

**Shape**
- Radii by role: 3px outlined buttons, 6px tiles/menus, 16px cards, 20–24px glass cards and
  containers, 999px pills and the mobile nav. Pick by role; don't invent in-betweens.

**Interaction and motion**
- Easing `cubic-bezier(.22,1,.36,1)`, 250–400ms. Color shifts, 2px translate on arrows,
  `translateY(-1px/-2px)` on buttons and cards, `scale(1.16)` on floating thumbnails.
- Hover on a group dims siblings (opacity .34, brightness .58) while the target glows.
- Marquees and wall scrolls pause on hover/focus. Everything respects
  `prefers-reduced-motion` (collapse durations to ~0).
- Focus ring: `2px solid accent`, offset 3px, on every interactive element. Tap targets are
  at least 44px tall.

## UX principles (details in `references/ux.md`)

- **Explore first, inform second.** The homepage is a canvas to wander; detail is one click away.
- **One next step per page.** Each page ends in one conversion path: the accent-colored text link or the single
  solid pill. Price, guarantee and first objection are shown up front on offer pages.
- **Same navigation everywhere.** Slim shared header (name + dot, links, Projects dropdown, orange
  CTA), an "Explore ↗" menu that lists every page, back links on articles, "by Name" credit on tools.
- **Filters fade-swap, never jump.** Fade out, wait 280ms, swap, fade in on the next frame; the old
  stage is `inert`; active tab uses `aria-current`.
- **Delight is desktop-only and optional.** Floating tiles (idle drift, pointer repulsion within 135px,
  spring .1 / damping .78), a morphing cursor ring and hover cards run only on
  `(hover:hover) and (pointer:fine)` with motion allowed. Touch and reduced-motion get a stacked
  grid with visible titles.
- **Overlays are accessible by default.** Lazy-loaded, background `inert`, Esc/outside click closes,
  focus returns, siblings navigation inside project detail.
- **Tools are live and forgiving.** Output updates on every input, state persists in
  `localStorage` (try/catch, validated), Copy / .md download / Reset, `/` focuses search,
  toasts say what to do next, empty states suggest example searches.
- **Performance is part of UX.** Preload fonts, eager first image, lazy rest, defer analytics,
  pause rAF when the tab is hidden, code-split heavy visuals, page-colored loading placeholders
  so dark pages never flash white.
- **Voice:** first person, short, concrete, warm. CTAs are plain verb + object
  ("Book my AI Session"). Reassure rather than sell ("No. If you can write a message, you can follow.").

## User-provided lists: muted scrolling strip

When the user provides brands, clients, skills, tools, technologies, programming languages, or spoken languages, include those items in a horizontal strip inspired by the supplied reference: a full-width, dark or theme-matched surface, large muted monochrome wordmarks or text, generous spacing, and softly faded edges. Use a seamless, slow horizontal marquee when the list is long enough to overflow; show a static row or wrapping list for short lists. Keep all items available on mobile.

Use the supplied names and order. Use official logos only when appropriate assets are provided or verified; otherwise render clean text wordmarks. Do not fabricate brands, skills, endorsements, clients, proficiency levels, or extra items to fill the strip. Label it to match what the list means, such as “Technologies I use”, “Languages”, or “Selected clients”; listing a brand never implies a client relationship without confirmation. Keep different kinds of lists separate when combining them would imply the wrong relationship.

Follow the reusable recipe in `references/components.md` §13. Pause movement on hover and keyboard focus; use a static, fully readable list for reduced motion. Keep an accessible original list and mark visual loop duplicates `aria-hidden` and `inert`. This is a content strip, not decorative icons appended to text labels; preserve the text-only control preference.

## Reference files

| File | Read it when |
|---|---|
| `references/tokens.css` | Starting any project in this style (colors, fonts, radii, motion, resets) |
| `references/components.md` | Building a specific component's look (14 recipes) |
| `references/ux.md` | Planning navigation, flows, interactions, states, copy, a11y, responsive rules |
| `references/scroll-motion.md` | Implementing smooth desktop scrolling and layered scroll-linked parallax |
| `references/interactions.js` | Implementing the floating canvas, cursor, or filter swap |
| `assets/fonts/` | Bundling Archivo display + text fonts |

## Porting to other stacks

**Tailwind**: map tokens into `theme.extend.colors` (`bg`, `raised`, `ink`, `muted`, `faint`,
`accent`), `fontFamily` (`display`, `text`, `script`), `borderRadius` (`sm 3px, md 6px, lg 16px, xl 24px`),
and add a `.eyebrow` utility (`text-[13px] font-medium uppercase tracking-[.14em]`). Keep
headline styles in a component class; `uppercase leading-[.95] tracking-tight` repeated everywhere drifts.

**React**: expose tokens as CSS variables on `:root` and style components with them, so a theme
swap (e.g. light variant) is a variable change.

**Flutter**: `ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Color(0xFF000000))`;
`ColorScheme.dark(primary: Color(0xFFF47721), surface: Color(0xFF0B0B0B), onSurface: Color(0xFFF5F0EA))`;
hairlines as `Color(0x1AF5F0EA)` 1px `Divider`s; bundle Archivo 800 for headlines
(`TextStyle(fontWeight: FontWeight.w800, height: .95, letterSpacing: -0.16)` + `.toUpperCase()`);
pills as `StadiumBorder`; cards `BorderRadius.circular(16)` with a 1px hairline border and no elevation.

## Do and don't

- Do let the headline be the hero. One huge uppercase line beats three medium elements.
- Do use plain text labels without decorative icons or arrows.
- Do use real photography in black-and-white or slightly dimmed, with gradient masks into the background.
- Don't use pure white text, gray backgrounds, multiple accent colors, gradients on buttons, or heavy shadows.
- Don't add rounded containers around everything. If a hairline can separate it, use the hairline.
- Don't center-align body copy (testimonial author rows and tiny captions excepted).
- Don't reuse Elron's name, portrait, logo, client work, or copy. This skill borrows the visual
  language only; his identity and content belong to him.

## Checklist before delivering

- [ ] Purpose, audience, identity, theme/colors, and motion preferences were collected or explicitly delegated
- [ ] Content, sections, and primary action fit the user’s purpose
- [ ] User-provided brand/skill/tool/language lists appear in the muted strip with accurate labels, accessible originals, and motion fallbacks
- [ ] Palette follows the agreed theme, with accessible text and focus contrast; use source black/warm-white defaults only when applicable
- [ ] Text labels have no decorative icons/arrows or leftover icon wrappers
- [ ] Chosen accent is used sparingly and consistently; at most one solid primary button per view
- [ ] Headlines uppercase, 800 display font, `.95` leading; at most one script accent word each
- [ ] Eyebrows uppercase with `.14em` tracking
- [ ] Dividers are hairlines; cards have 1px line borders and no shadows
- [ ] Radii come from the set 3 / 6 / 16 / 24 / 999
- [ ] Hover, focus-visible, and reduced-motion states exist for every interactive element
- [ ] When enabled, parallax changes element offsets with scroll, composes with existing transforms, and preserves smooth scrolling; mobile/reduced-motion remain native and static
- [ ] Layout holds at 860px and 720px (nav becomes bottom pill / disclosure menu)
- [ ] Tap targets ≥ 44px
- [ ] UX checklist in `references/ux.md` §14 passes (one next step per page, shared nav + Explore menu,
      fade-swap filters, inert overlays, persisted tool state, touch/reduced-motion fallbacks, concrete first-person copy)

## Smooth scrolling and parallax

When the user chooses an expressive motion treatment, combine smooth, eased desktop scrolling with actual scroll-linked parallax. Parallax means elements move at different speeds as the page scrolls; one-time fades or reveals alone do not satisfy it. Preserve the user’s existing smooth scrolling when adding parallax.

Read `references/scroll-motion.md` before implementing. Use restrained depth layers: decorative hero elements move at different rates, project tiles drift in alternating directions, and section headings shift subtly. Compose parallax with existing hover, floating physics, and reveal effects without overwriting their transforms. Bound offsets to prevent overlap or clipping. Adapt the effect to the site’s purpose and the user’s motion preferences.

Keep touch/mobile scrolling native and disable parallax for reduced motion. Preserve keyboard navigation, anchor links, nested scrolling, zoom gestures, and dialog scrolling. Do not add paintbrush trails, color inversion, or scroll painting as part of this behavior.

## Cursor behavior

- **Smooth, delayed cursor:** when cursor effects are enabled in the agreed brief, use a softly eased follower rather than snapping it directly to the pointer. Start from `startCustomCursor()` in `references/interactions.js`. Keep interaction targets clickable and keyboard focus visible.
- **Mobile and reduced-motion fallbacks:** enable the custom cursor only for desktop fine pointers with motion allowed. Preserve the native cursor on touch/coarse pointers, mobile layouts, reduced-motion settings, and when initialization fails. Clean up listeners and animation frames when disabled.

## Default typography

Use Archivo for body and navigation at weight 500–600. Set base body text to 18px/1.8 at weight 500; use 17px on narrow mobile layouts. Set navigation and buttons to 15px/600, labels and metadata to 13px/600, and project titles to 19px/600. Keep Archivo Condensed display headings at 800 and Georgia Italic accent words at 400. Do not shrink functional text below 13px on mobile; reflow it instead. These user-approved defaults override smaller sizes or lighter weights in any historical recipe.
