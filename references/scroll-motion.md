# Smooth scrolling and layered parallax

## Scope

Use when the agreed brief calls for expressive scrolling. Keep existing scroll easing when adding parallax. Smooth scrolling changes how the page moves; parallax changes how individual elements move relative to the page. Implement both when requested. Do not substitute reveal-on-entry animations for parallax.

## Smooth scrolling

- Enable desktop wheel easing only for `(hover:hover) and (pointer:fine)` above 860px when reduced motion is off. Keep touch and mobile scrolling native.
- Track a clamped target scroll position. On each animation frame ease the actual scroll toward it using `1 - Math.exp(-dt / 110)` with frame time in milliseconds. Stop within about 0.5px. Clamp frame time after interruptions and recompute document limits as content changes.
- Normalize wheel `deltaMode`. Leave horizontal gestures, Shift-wheel, Ctrl/Meta zoom, nested scroll containers, and open native dialogs untouched. Prevent the default wheel action only when the effect handles it.
- Avoid competing CSS and JavaScript scroll smoothing: use `scroll-behavior:auto` while the wheel easing is active; apply frame updates instantly. Preserve anchor navigation and cancel pending easing on pointer interaction, navigation keys, resizing, and hash changes so it cannot pull users back.
- Preserve keyboard scrolling, text selection, focus navigation, browser Find, and scrollbars. Stop scheduling frames once settled and pause when hidden. Clean up listeners and frames on teardown or preference changes.

## Parallax

- Use the actual document scroll position, including native keyboard, scrollbar, and anchor scrolling. Schedule at most one parallax frame per scroll update with a passive listener.
- Separate layers by role. Hero decorative layers can use rates from 0.10 to 0.24, bounded to around 125px. Project tiles can alternate rates such as `0.075, -0.065, 0.045, -0.09`, bounded to 20px. Headings can use rates around `0.09` or `-0.075`, bounded to 22px. These are starting values, not mandatory effects on every element.
- For a section-relative layer, calculate `distance = viewportHeight * 0.5 - (anchorRect.top + anchorRect.height * 0.5)`, then `offset = clamp(distance * speed, -limit, limit)`. For hero artwork, a useful distance is `-heroRect.top`.
- Measure an untransformed section/container anchor rather than the moving element, avoiding a measurement/transform feedback loop. Batch layout reads before style writes.
- Write a CSS custom property such as `--parallax-y` and compose via the individual property `translate: 0 var(--parallax-y, 0px)`. This can coexist with existing `transform`-based physics, rotations, and reveals. If the element already uses individual translate, add a dedicated wrapper or explicitly compose offsets rather than replacing it.
- Keep offsets inside the available layout gaps. Do not let headings overlap body copy or tiles overlap adjacent controls. Preserve accessible focus visibility, click targets, and hover-card alignment. Avoid animating entire reading paragraphs or forms.
- Recollect dynamic project layers after category swaps; remove obsolete styles. Recalculate when layout dimensions change. Do not create mutation-observer loops by observing the same style writes.
- Disable parallax at or below 860px, on coarse/touch pointers, and for `prefers-reduced-motion:reduce`. Remove transforms and unnecessary `will-change` when disabled. Keep all content visible.

## Optional complementary reveals

Use restrained one-time opacity/vertical entrance transitions for section introductions. Keep them separate from parallax. Use IntersectionObserver, expose focused sections immediately, and keep content visible when JavaScript, the observer, or motion effects are unavailable.

## Verify

- Confirm different layer offsets at two scroll positions in both directions; movement must respond to scrolling, not only elapsed time.
- Check that parallax coexists with tile drift, hover scaling, and any existing cursor effect.
- Check anchors, keyboard navigation, nested scrollers, and modal scrolling; there must be no snapping back to a stale target.
- Check no overlap, clipped focus outlines, new horizontal overflow, or inaccessible content.
- Check native touch scrolling and static reduced-motion layouts, including live preference changes.
