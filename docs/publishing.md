# Publishing

Publish from the repository root with Node.js and npm installed. GitHub access must
allow pushes to `ralphjenrey/kinetic-ui`, and the npm account must have publish access
to `@ralphjenrey/kinetic-ui`.

## Check the release

```sh
git status --short
npm run check
npm pack --dry-run
```

Review the tarball file list. It should contain the skill, agent metadata, references,
assets, documentation, package metadata, and license notices. Local caches, credentials,
and `node_modules` must stay out of the release. The `files` allowlist in `package.json`
controls package contents; npm also includes standard package files such as the README.

Before changing prose, read the current document in full and check examples against
the source. Keep documented behavior consistent with the shipped helpers.

## Publish a version

For a subsequent release, update `CHANGELOG.md`, then choose the appropriate version:

```sh
npm version patch
git push origin main --follow-tags
```

For the first release, commit the files and create the matching `v0.1.0` tag before pushing.
Authenticate and publish:

```sh
npm login
npm whoami
npm publish --access public
```

Complete any browser authentication or two-factor challenge npm requests. Never commit
an npm token. `prepublishOnly` runs the JavaScript syntax check before publication.
An existing name and version cannot be published again; fixes require a new version.

## Verify publication

```sh
npm view @ralphjenrey/kinetic-ui version dist-tags repository.url
```

Install the published version in a temporary project and confirm these imports resolve:

```js
import { seededLayout } from '@ralphjenrey/kinetic-ui/interactions';
```

```js
import '@ralphjenrey/kinetic-ui/tokens.css';
```

The CSS import requires a bundler with CSS support. Confirm its emitted font URLs load
in a browser. Review [CHANGELOG.md](../CHANGELOG.md) when preparing the next release.
