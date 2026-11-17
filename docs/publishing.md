# Publishing

Publish from the repository root with Node.js and npm installed. GitHub access must
allow pushes to `ralphjenrey/kinetic-ui`, and the npm account must have publish access
to `@ralphjenrey/kinetic-ui`.

## Check the release

```sh
git status --short
npm run check
npm pack --dry-run
bash -n install.sh
```

Review the tarball file list. It should contain the skill, agent metadata, references,
assets, documentation, package metadata, and license notices. Local caches, credentials,
and `node_modules` must stay out of the release. The `files` allowlist in `package.json`
controls package contents; npm also includes standard package files such as the README.
The release also includes `install.sh` and both plugin manifests and marketplaces.

Before changing prose, read the current document in full and check examples against
the source. Keep documented behavior consistent with the shipped helpers.

## Publish a version

For a subsequent release, update `CHANGELOG.md`, then choose the appropriate version:

```sh
npm version patch
```

Keep the version in `.claude-plugin/plugin.json` and `.codex-plugin/plugin.json` in
sync with `package.json`. Update those manifests before tagging the release; use
`npm version patch --no-git-tag-version` when preparing all version changes in one commit.
Commit the release files, create the matching version tag, and push the commit and tag.

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

If npm reports a staged release, a successful publish means the submission was accepted.
It does not confirm that users can install that version yet. A `0.0.0-stage` holding
version means the operational package is still awaiting release. Wait until the requested
version appears in the registry before announcing availability.

Install the published version in a temporary project and confirm these imports resolve:

```js
import { seededLayout } from '@ralphjenrey/kinetic-ui/interactions';
```

```js
import '@ralphjenrey/kinetic-ui/tokens.css';
```

The CSS import requires a bundler with CSS support. Confirm its emitted font URLs load
in a browser. Review [CHANGELOG.md](../CHANGELOG.md) when preparing the next release.
