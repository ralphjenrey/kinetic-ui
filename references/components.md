# Component recipes

**Label preference:** Use text-only buttons, links, navigation, and CTAs. Omit decorative arrows, icons, circled glyphs, and crosses beside text, including “Next”, “Previous”, and “Close”. Remove their wrappers and spacing. This overrides the historical icon recipes below; preserve accessible functional controls and focus states.


Use 18px/500 base text, 15px/600 navigation and buttons, 13px/600 labels and metadata, and 19px/600 project titles. These defaults override historical smaller type values below. Preserve 800 display headings and 400 Georgia italic accents. Reflow mobile layouts instead of reducing functional text below 13px.

All snippets assume `tokens.css` is loaded. Values are taken from the live site's CSS.

## Contents
1. Headlines and the script accent
2. Eyebrow / section label
3. Buttons and CTAs
4. Category nav (underline tabs, mobile bottom pill)
5. Filter chips
6. Header and Explore menu
7. List rows with arrow
8. Cards (preset cards, testimonial cards)
9. Floating work canvas and hover card
10. Split hero (identity column)
11. Article / long-form page
12. Tool pages (prompt-builder: sidebar, steps, inputs)
13. Social rail, marquee, cursor
14. Variants (AI-session warm dark, light)

---

## 1. Headlines and the script accent

Uppercase, condensed, very tight leading. One word per headline may switch to an
italic serif in orange, lowercase.

```css
.headline{font-family:var(--font-display);font-weight:800;text-transform:uppercase;
  letter-spacing:-.01em;line-height:.95;text-wrap:balance;margin:0;
  font-size:clamp(40px,6vw,72px)}            /* page titles */
.headline--hero{font-size:clamp(64px,9vw,110px);line-height:1}   /* index pages */
.headline--section{font-size:34px}           /* 28px under 720px */
.headline em,.headline span.accent{font-family:var(--font-script);font-style:italic;
  font-weight:400;letter-spacing:-.04em;text-transform:none;color:var(--accent)}
```
```html
<h1 class="headline">Designer. <em>creator.</em> Problem solver.</h1>
```
Never fake a bold display weight; only 800 exists. The homepage name line is the one
exception: Poppins 700 uppercase, `clamp(36px,4.6vw,58px)`, line-height 1.02, last word orange.

## 2. Eyebrow / section label

```css
.eyebrow{font:var(--t-eyebrow);letter-spacing:.14em;text-transform:uppercase;color:var(--ink);margin:0}
.eyebrow--accent{color:var(--accent);font-size:11px;font-weight:600;letter-spacing:1.7px}
.label-faint{font-size:11px;font-weight:600;letter-spacing:.14em;text-transform:uppercase;color:var(--faint)}
```
Orange eyebrow with muted `/` or `·` separators between segments for article meta.

## 3. Buttons and CTAs

Three tiers. Prefer the quietest that works.

```css
/* A. Outlined, tiny radius — the default brand button. Orange arrow glyph inside. */
.btn{display:inline-flex;align-items:center;justify-content:center;gap:15px;
  border:1px solid var(--accent-border);border-radius:var(--r-sm);padding:10px 15px;
  color:var(--ink);font:400 12px/1.7 var(--font-text);background:transparent;transition:border-color var(--t-fast),background var(--t-fast)}
.btn span{color:var(--accent)}
.btn:hover{border-color:var(--accent);background:#19130e}

/* B. Text CTA with circled icon (hero actions) */
.cta{display:inline-flex;align-items:center;gap:14px;min-height:44px;font-size:12px;font-weight:600;
  letter-spacing:.1em;text-transform:uppercase;transition:color var(--t-fast)}
.cta__icon{width:38px;height:38px;border:1.5px solid var(--accent);color:var(--accent);border-radius:50%;
  display:flex;align-items:center;justify-content:center;transition:background var(--t-fast),color var(--t-fast)}
.cta:hover{color:var(--accent)}
.cta:hover .cta__icon{background:var(--ink);border-color:var(--ink);color:var(--bg)}
.cta--quiet{color:var(--muted)}                       /* secondary action */
.cta--quiet .cta__icon{color:var(--muted);border-color:rgba(245,240,234,.26)}

/* C. Solid pill — one per view, the primary conversion action */
.pill{background:var(--accent);color:var(--bg);border-radius:var(--r-pill);padding:10px 13px;
  font-size:11.5px;font-weight:600;letter-spacing:.04em;white-space:nowrap;
  transition:background var(--t-fast),transform var(--t-fast)}
.pill:hover{background:var(--ink);transform:translateY(-1px)}

/* Ghost pill with orange dot-icon ("Discovery") */
.pill-ghost{display:inline-flex;align-items:center;gap:7px;padding:4px 10px 4px 4px;height:40px;
  border:1px solid rgba(245,240,234,.22);border-radius:var(--r-pill);color:var(--muted);font-size:10px;font-weight:600}
.pill-ghost__icon{width:26px;height:26px;border:1px solid rgba(244,119,33,.5);border-radius:50%;
  color:var(--accent);display:grid;place-items:center;font-size:8px;font-weight:700}
.pill-ghost:hover{color:var(--ink);background:rgba(244,119,33,.07);border-color:rgba(244,119,33,.62)}
```
Tool pages use a larger primary: orange fill, `#0b0b0b` text, 24px radius, 14px/700,
padding 14px 18px, hover `#dc5a16`, disabled opacity .4.

## 4. Category nav

Desktop: row of text tabs above a 1px hairline; active tab is orange with a 2px orange
underline that animates in (`scaleX(.35)→1`, .35s). Contact actions sit right.
Mobile (≤860px): becomes a fixed bottom pill.

```css
.cat-nav{height:var(--nav-height);display:flex;align-items:center;padding:0 8px 0 30px;position:relative}
.cat-nav::after{content:"";position:absolute;left:30px;right:8px;bottom:0;height:1px;background:var(--line)}
.cat-nav ul{display:flex;gap:clamp(14px,1.6vw,30px);list-style:none;margin:0;padding:0;overflow-x:auto;scrollbar-width:none}
.cat-nav__item{position:relative;padding:6px 2px 14px;font-size:14px;font-weight:500;letter-spacing:.01em;color:var(--muted);white-space:nowrap;transition:color var(--t-fast)}
.cat-nav__item:hover{color:var(--ink)}
.cat-nav__item.is-active{color:var(--accent)}
.cat-nav__item.is-active::after{content:"";position:absolute;left:2px;right:2px;bottom:-1px;height:2px;border-radius:2px;background:var(--accent)}
@media (max-width:860px){
  .cat-nav{position:fixed;left:12px;right:12px;bottom:12px;height:auto;padding:11px 14px 11px 30px;z-index:50;
    background:rgba(7,7,7,.88);border:1px solid var(--line);border-radius:var(--r-pill);
    backdrop-filter:blur(16px);-webkit-backdrop-filter:blur(16px)}
  .cat-nav::after{display:none}
  .cat-nav__item{font-size:12px;padding-bottom:6px}
  .cat-nav__item.is-active::after{bottom:0}
}
```
Add `padding-bottom:calc(132px + env(safe-area-inset-bottom))` to the scrolling content on mobile.

## 5. Filter chips (tool pages)

```css
.chip{padding:8px 14px;border:1px solid #2a2a30;border-radius:18px;background:#151518;color:var(--ink);font-size:12px;font-weight:600}
.chip:hover{border-color:var(--accent)}
.chip.active{background:var(--accent);border-color:var(--accent);color:#0b0b0b}
```
Step-nav variant: same chip, `color:var(--muted)`, in a sticky bar with
`background:rgba(0,0,0,.94);backdrop-filter:blur(8px);border-bottom:1px solid var(--line)`.

## 6. Header and Explore menu

Slim 48px header: black, 1px bottom hairline at 8% ink, 13px muted text.
Name on the left in 15px/600 ink with an 8px orange dot. Nav on the right with
28px gaps. Dropdown panel: `#0b0b0b`, 1px line border, 8px radius, 8px padding,
shadow `0 12px 32px rgba(0,0,0,.6)`, items 10px 12px padding with
`rgba(245,240,234,.06)` hover. Mobile (≤720px): nav collapses into a pill-outlined
"Menu" disclosure (`border:1px solid rgba(245,240,234,.26)`, radius 999px).

The "Explore ↗" menu is a native `<details>` with a fixed panel (350px max, 6px radius,
18px padding, `box-shadow:0 18px 60px #0008`). Title is 10px/600 orange with 1.7px
tracking. Rows are 44px tall, 14px, separated by hairlines, orange `↗` at the right edge.
Escape and outside-click close it.

## 7. List rows with arrow

Used for brands, resources, topics. Hairline top and bottom per row, no card chrome.

```css
.rows{list-style:none;margin:0;padding:0;border-top:1px solid var(--line)}
.rows li{border-bottom:1px solid var(--line)}
.rows a{display:grid;grid-template-columns:210px minmax(0,1fr) auto;gap:20px;align-items:baseline;min-height:44px;padding:18px 2px}
.rows .name{font:var(--t-eyebrow);letter-spacing:.14em;text-transform:uppercase;transition:color var(--t-fast)}
.rows .desc{font:400 15px/2 var(--font-text);color:var(--muted)}
.rows .go{color:var(--accent);font-size:14px;transition:transform var(--t-fast)}
.rows a:hover .name{color:var(--accent)}
.rows a:hover .go{transform:translate(2px,-2px)}
@media (max-width:720px){.rows a{grid-template-columns:minmax(0,1fr) auto;gap:2px 16px}.rows .desc{grid-area:2/1;font-size:14px}.rows .go{grid-area:1/2}}
```

## 8. Cards

Default card is flat: 1px line border, radius 4–16px, no shadow. Hover changes the border
to orange (`#f477216b` at 42% for glassy cards).

```css
.card{border:1.5px solid #2a2a30;border-radius:var(--r-lg);background:#151518;overflow:hidden;transition:border-color .15s,transform .15s}
.card:hover{border-color:#5b5b65;transform:translateY(-2px)}
.card.selected{border-color:var(--accent);box-shadow:0 0 0 3px rgba(242,107,31,.14)}

/* Glassy testimonial card */
.quote-card{background:linear-gradient(145deg,rgba(255,255,255,.055),transparent 42%),rgba(16,15,14,.94);
  border:1px solid rgba(245,240,234,.11);border-radius:20px;box-shadow:0 18px 54px rgba(0,0,0,.28);
  padding:clamp(20px,2vw,30px);transition:border-color .26s,background-color .26s,transform .26s}
.quote-card:hover{border-color:rgba(244,119,33,.42);transform:translateY(-2px)}
.quote-card blockquote{margin:0;font-size:clamp(15px,1.18vw,20px);font-weight:450;line-height:1.48;letter-spacing:-.018em}
.quote-card .meta{font-size:10px;font-weight:600;letter-spacing:.13em;text-transform:uppercase;color:rgba(245,240,234,.5)}
.quote-card .signal{width:7px;height:7px;border-radius:50%;background:var(--accent);box-shadow:0 0 0 5px rgba(244,119,33,.1)}
.quote-card figcaption{border-top:1px solid rgba(245,240,234,.09);padding-top:16px;margin-top:30px;display:flex;gap:11px;align-items:center}
.avatar{width:36px;height:36px;border-radius:50%;border:1px solid rgba(244,119,33,.36);background:rgba(244,119,33,.08);color:var(--accent);display:grid;place-items:center;font-size:10px;font-weight:700}
```
The testimonial wall container: `border-radius:24px`, `#060606` base with two soft orange
radial glows (88% 8% and 12% 84%, 13% and 7% alpha) and a 72px faint grid overlay masked top/bottom.
Columns auto-scroll vertically (136s linear, middle column reversed, pause on hover/focus).

## 9. Floating work canvas

Homepage portfolio items are thumbnails floating on a canvas, dimmed until pointer proximity.

- Tile: radius 6px, resting `opacity:.88`, brightness rises with `--proximity`.
- When any tile is hovered, the rest drop to `opacity:.34; filter:brightness(.58) saturate(.58)`.
- Hovered tile: `scale:1.16`, `z-index:40`, ring `0 0 0 1.5px accent, 0 0 28px -6px accent-dim, 0 20px 40px -16px #000a`.
- Behind them, ghost tiles at `opacity:.08`, grayscale, blur 3px, drifting 6–8px on 10s loops.
- Hover card beside the tile: title 13px/700 uppercase (.02em), description 12px muted, each line fades up 6px with 50ms stagger.
- Mobile/stacked: CSS grid `repeat(auto-fit,minmax(min(100%,260px),1fr))`, gap 16px, radius 9px, bottom gradient label (`transparent→#020202f0`, title 13px, subtitle 10.5px muted).

## 10. Split hero

Desktop: two columns. Left "identity" column is 40% wide with a black-and-white portrait
masked into the black (`mask-image: linear-gradient(110deg,#000 55%,rgba(0,0,0,.75) 72%,rgba(0,0,0,.25) 88%,transparent)`)
and a 72px black→transparent edge gradient. Text is bottom-aligned with padding `48px 40px 40px 72px`:
name, eyebrow tagline (13px/500, .14em), muted intro (14px/1.6, max 380px), CTA stack, and a hairline-topped
footer with faint uppercase location (11px, .1em) and a tiny visitor counter (9px, tabular nums).
Right column is the canvas with the category nav on top.

Mobile (≤860px): stack. Portrait shrinks to the left 46–52% of a 430–620px tall hero with a horizontal
fade; text sits to the right (`padding-left:38%`). Intro hides. Social icons move to the top right as an
18px row. Footer pins to the hero bottom.

## 11. Article / long-form page

- Page bg `#0e0d0c` or pure black; text column max 720px, TOC 194px sticky at left on desktop (collapses above content on mobile).
- H1: display font, clamp(48px,6.2vw,78px), uppercase, .95–1.04 leading, `text-wrap:balance`.
- Deck: 19px/1.6 `#b8b0a6`. Byline 12px muted.
- Body: 17px/1.9 `#d3ccc3`; first paragraph 21px/1.75 `#ece4da`. H2 inside body: display font uppercase 34px (28px mobile). Part dividers: `border-top:2px solid accent; padding-top:30px`.
- Links: ink with `text-decoration:underline #705039; text-underline-offset:4px`, underline turns orange on hover.
- Inline code: `#f2bb91` on `#211d19`, 1px `#332a23` border, 4px radius. Code blocks: `#171411`, 1px `#332a23` border, **2px left border `#9a5b2d`**, 2px radius, padding 23px 25px, 13px/1.8 mono, thin custom scrollbar `#4a3d32`.
- Blockquote: 2px left border orange, 24px left padding, 18px `#eee4d9`.
- Tables: collapse, 13px, header with top hairline and `#544434` bottom border, rows with hairlines, first column flush left.
- Footer: hairline top, label (10px/600 tracking), email at 21px/500, outlined `.btn` for support, 8-up social icon grid at 72% opacity.
- Next-reads: 2-col grid of 1px-bordered 4px-radius cards that go orange on hover.
- A skip link that appears on focus (orange bg, `#0e0d0c` text).

## 12. Tool pages (prompt builders)

Two-column workspace: scrolling main + 440px sticky sidebar (360px ≤1100px; stacks ≤800px with a fixed
full-width orange "jump to prompt" bar at the bottom).

- Sidebar: `#111113`, 1px `#2a2a30` left border, 24px 22px padding. Header row with orange 6px "live" dot + 10px/600 tracking label. Output well: `#151518`, 1px border, 14px radius, 12px/1.7 mono. Actions: orange primary (24px radius) + outlined reset.
- Sections are separated by 1px lines with 32px padding; numbered headings use an orange small number before the title.
- Search field: 12px radius, panel bg, inline `kbd` with 4px radius.
- Inputs inherit `Elron Text`. Labels and counts are 10px/.6–1.2px tracking, muted.

## 13. Social rail, marquee, cursor

- Social rail: vertical, fixed at `left:28px`, centered; 25.6px monochrome icons at `opacity:.46` → 1 on hover; tooltip pill on hover (`#050505f0`, 1px line border, 10px text, slides 4px).
### User-provided brand, skill, or language strip

Include this component when the user supplies a relevant list. Match the reference’s quiet horizontal row: large muted wordmarks, wide gaps, monochrome treatment, no item cards, and soft fades at the ends. Adapt surface and ink to the chosen theme. Use a factual label above it; do not turn tool usage into a claim of client work.

- Semantic structure: `<section aria-labelledby="list-title">` with a visible heading and an original `<ul>` of the exact supplied items. Use clean text if official logo assets are unavailable. Image-only wordmarks need the correct brand/name as alt text.
- Layout: full-width overflow region; items are flex children with `flex-shrink:0`, `gap:clamp(32px,5vw,80px)`, wordmarks `font-size:clamp(24px,3vw,48px)`, and consistent logo height around 34–44px with `object-fit:contain`. Keep the section title at least 13px/600.
- Color: muted neutral ink and grayscale logos. Maintain readable text contrast; use `--muted` for text rather than reducing text opacity to the reference’s very faint level. Keep colored logos monochrome when permitted by supplied assets.
- Loop: duplicate the visual list once inside a `width:max-content` track; use identical spacing in both copies and animate `translateX(0)` to `translateX(-50%)` over about 34 seconds, linear and infinite. Include trailing padding equal to the gap in each copy so the seam is continuous. Mark the copy `aria-hidden="true"` and `inert`; never duplicate it as accessible content.
- Edge fade: apply `mask-image:linear-gradient(90deg,transparent,#000 6% 94%,transparent)` to the overflow viewport. Keep enough inset that names remain discoverable as they move.
- Pause on `:hover` and `:focus-within`; offer a text-only Pause/Resume control for continuous autoplay lasting more than five seconds, with its paused state exposed. Do not add decorative icons to that control. If any list items are links, make their keyboard focus fully visible and pause before they can drift out of view.
- Reduced motion: disable animation, hide the duplicate, remove edge masks, and wrap the original list so every item can be read. Use the same static fallback if JavaScript or animation enhancement is unavailable.
- Mobile: reduce gaps while preserving readable labels; allow horizontal scrolling or use a wrapping static row. Never clip away items permanently. For one to three short items, use a static row instead of repeating filler.
- Confirm exact supplied entries, a seamless loop, Pause/Resume, hover/focus pause, mobile access, and reduced-motion behavior.

- Custom cursor (desktop ≥861px only): 7px ink dot + ring that morphs: default filled orange, interactive tinted orange, "view" filled with a black uppercase 11px label, "close" dark glass. Hidden on touch. Always keep the native cursor available if JS fails.

## 14. Variants

- **AI-session page (warm dark):** `#171815` paper, `#f3f0e8` ink, `#aaa99f` muted, hairline `#ffffff24`, orange `#ff6b25`, film-grain overlay (SVG feTurbulence at 16% opacity). Monogram tile: 38px, 8px radius, orange bg, display-font "E". Huge stacked headline `clamp(70px,min(8.5vw,14svh),150px)/.86`. Numbered topic list with tabular numerals and `→` arrows. Photo square with 3px radius.
- **Light surfaces:** white `#fff`, ink `#161616`, muted `#5c5c5c`, line `#e4e4e4`, orange `#ff6702`, orange-as-text `#b54500` (use this for small text on white for contrast). Pill buttons: ink fill, 999px radius, hover swaps to orange with ink text. Focus ring 3px orange.
