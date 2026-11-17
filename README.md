# kinetic-ui

An agent skill for editorial interfaces, with CSS tokens, component recipes, and
browser interaction helpers. Its visual references come from elronnaranja.com:
condensed Archivo headlines, hairline dividers, warm text, and floating project tiles.
The skill asks about the project's purpose, content, colors, and motion before building.

This package contains design instructions and reusable source files. It has no CLI,
framework components, or runtime dependencies. The JavaScript helpers use browser APIs.

## Demos

- [Demo 1](https://ralphjenrey.github.io/kinetic-ui-sample1)
- [Demo 2](https://ralphjenrey.github.io/kinetic-ui-sample2)
- [Demo 3](https://ralphjenrey.github.io/kinetic-ui-sample3)

## Install

This repository holds one skill, `kinetic-ui`. Choose one installation method below.
Each method loads the same skill and its references, fonts, and interaction helpers.

### Skills CLI

Use the [Skills CLI](https://github.com/vercel-labs/skills) to install for Codex,
Claude Code, Cursor, OpenCode, Gemini CLI, or another supported agent:

```sh
npx skills add ralphjenrey/kinetic-ui
```

To select the skill explicitly:

```sh
npx skills add https://github.com/ralphjenrey/kinetic-ui --skill kinetic-ui
```

The CLI lets you choose agents and installs to the current project by default.
Add `-g` for a global installation, or `-a codex` or `-a claude-code` to select an agent.

### Claude Code plugin

Run these as two separate commands inside Claude Code:

```text
/plugin marketplace add ralphjenrey/kinetic-ui
/plugin install kinetic-ui@kinetic-ui
```

The plugin exposes the skill as `/kinetic-ui:kinetic-ui`.

### Codex plugin

Run these as two separate commands in your terminal:

```sh
codex plugin marketplace add ralphjenrey/kinetic-ui
codex plugin add kinetic-ui@kinetic-ui
```

Start a new Codex session afterwards so the installed skill is loaded.

### From a clone

The installer links this clone into your user skill directory. Run `git pull` inside
the clone to update the linked files. Keep the clone in place while using the skill.

```sh
git clone https://github.com/ralphjenrey/kinetic-ui.git
cd kinetic-ui
./install.sh                # Claude Code: ~/.claude/skills/kinetic-ui
./install.sh --codex        # Codex: ~/.agents/skills/kinetic-ui
./install.sh --all-agents   # Both
```

To remove the links created by this clone:

```sh
./install.sh --uninstall
./install.sh --codex --uninstall
./install.sh --all-agents --uninstall
```

The script supports macOS and Linux with Bash. It refuses to replace an existing
directory or a link owned by another installation. Run `./install.sh --help` for
custom directory options. Start a new agent session after installing or updating.

### npm package

To use the CSS and JavaScript helpers in an application:

```sh
npm install @ralphjenrey/kinetic-ui
```

This adds the package to `node_modules`. Use one of the methods above to make the skill
available to an agent.

## Use the skill

Give the agent a brief with your audience, content, theme, and preferred motion:

```text
Use $kinetic-ui to build my software engineer portfolio.
Use a light theme with a blue accent. Include my supplied projects and contact details.
Keep motion subtle and preserve native scrolling on mobile.
```

The black and orange palette is a fallback when you choose it or delegate colors.
Your brief takes precedence. The skill calls for text-only control labels, readable
Archivo typography, keyboard focus states, and touch and reduced-motion fallbacks.
Project names, client relationships, and personal claims must come from your content.

## Use the CSS directly

With a bundler that supports CSS imports:

```js
import '@ralphjenrey/kinetic-ui/tokens.css';
```

The stylesheet includes global resets, element styles, font declarations, and tokens.
Review it before importing into an existing application. Its font URLs resolve to the
packaged `assets/fonts/` directory. If you copy the CSS elsewhere, update those URLs
and distribute `OFL.txt` alongside the fonts.

Override tokens after the import to match your theme:

```css
:root {
  color-scheme: light;
  --bg: #faf8f5;
  --bg-raised: #f0ede8;
  --ink: #171717;
  --muted: #55514d;
  --faint: #68635e;
  --line: rgba(23, 23, 23, .15);
  --line-strong: rgba(23, 23, 23, .3);
  --accent: #2359c4;
  --accent-dim: rgba(35, 89, 196, .45);
  --accent-wash: rgba(35, 89, 196, .07);
  --accent-border: #7088b8;
}
```

For article or code surfaces, also override `--bg-article` and `--bg-code`.
Check contrast for your actual text sizes, backgrounds, and interaction states.

## Use the interaction helpers

Import helpers from the `interactions` subpath. There is no default package-root export.

```js
import {
  canUseFancy,
  seededLayout,
  startFloatingPhysics,
} from '@ralphjenrey/kinetic-ui/interactions';

const canvas = document.querySelector('.project-canvas');
const elements = [...canvas.querySelectorAll('.project-tile')];
let stop = () => {};

if (canUseFancy()) {
  const positions = seededLayout(
    elements.map((_, index) => ({
      id: String(index), aspect: 0.75, minWidth: 120, maxWidth: 160,
    })),
    { width: canvas.clientWidth, height: canvas.clientHeight, seed: 42 },
  );

  const tiles = positions.map((position, index) => {
    const el = elements[index];
    Object.assign(el.style, {
      position: 'absolute', left: `${position.x}px`, top: `${position.y}px`,
      width: `${position.width}px`, height: `${position.height}px`,
    });
    return { ...position, el };
  });

  stop = startFloatingPhysics(canvas, tiles, () => null);
}

// Call stop() when the view unmounts.
```

Give the canvas `position: relative` and an explicit height. Use a readable static grid
as its default layout. Recalculate positions after resizing or changing content.
Stop animation and restore the static layout when motion or pointer preferences change.
The layout solver is iterative; dense content can still overlap if the canvas is too small.

| Export | Purpose |
| --- | --- |
| `hashString(value)` | Convert a string to a numeric seed. |
| `mulberry32(seed)` | Create a deterministic random-number generator. |
| `MATCH_FANCY` | Media query for a fine pointer with hover. |
| `canUseFancy()` | Check pointer, hover, and reduced-motion preferences in the browser. |
| `seededLayout(items, options)` | Calculate tile positions and motion parameters. `aspect` is height divided by width. |
| `startFloatingPhysics(container, tiles, getHoveredId)` | Animate positioned tiles; return a cleanup function. |
| `hoverCardPlacement(tile, width, height, cardHeight?, gap?)` | Suggest a side and coordinates for a hover card. |
| `startCustomCursor(dot, ring, label)` | Start the cursor effect when preferences allow; return partial cleanup. |
| `createFilterSwap(stage, render, delay?)` | Return a fade-swap function; the default delay is 280 ms. |

Call browser-dependent functions after mounting, outside server rendering. Floating
physics needs the caller to check `canUseFancy()`. Cursor cleanup currently leaves its
anonymous pointer press listeners attached. Filter swaps have no public cancellation
method and use the supplied delay even with reduced motion, so pass `0` when appropriate
and manage view teardown. Review and adapt these reference helpers for your application.

## Reference guide

| File | Contents |
| --- | --- |
| [SKILL.md](SKILL.md) | Agent instructions, brief questions, design rules, and delivery checklist. |
| [references/tokens.css](references/tokens.css) | Colors, typography, spacing-related layout values, and base styles. |
| [references/components.md](references/components.md) | Recipes for navigation, buttons, cards, articles, and tools. |
| [references/ux.md](references/ux.md) | Navigation, overlays, filters, accessibility, and content states. |
| [references/scroll-motion.md](references/scroll-motion.md) | Smooth scrolling and scroll-linked parallax guidance. |
| [references/interactions.js](references/interactions.js) | Layout, floating physics, cursor, and filter helpers. |
| [agents/openai.yaml](agents/openai.yaml) | Agent display metadata and default prompt. |
| [docs/publishing.md](docs/publishing.md) | Maintainer checks and release commands. |

Some historical recipes use smaller typography or decorative icons. The explicit
overrides in `SKILL.md` take precedence over those examples.

## Develop

```sh
git clone https://github.com/ralphjenrey/kinetic-ui.git
cd kinetic-ui
npm run check
npm pack --dry-run
```

There is no build step. The check validates JavaScript syntax; it does not test browser
behavior. Verify interactions, responsive layouts, keyboard navigation, and reduced
motion in the application that uses these files.

## License and credits

Project code and documentation use the [MIT license](LICENSE). Archivo fonts use the
[SIL Open Font License 1.1](assets/fonts/OFL.txt). See
[third-party notices](THIRD_PARTY_NOTICES.md) for attribution and scope.
This project is independent of Elron Naranja. Use your own identity, images, and content.
