# ACF JSON Manager

Manages ACF local JSON for plugins and themes.

## Environment Setup

This project uses a single `.env` file to make the development process a little
easier. Normally, this plugin is installed via `composer`. However, trying to
deploy the plugin with `composer` while trying to iterate rapidly would be a
nightmare. To make life easier, this repo contains a script (`bin/dev_sync.sh`)
that copies the plugin code to where ever it would normally be installed with
`composer`.

### Configuration

1. Duplicate `.sample.env` in the root project directory, and name it `.env`.
2. Open `.env` and update the paths as needed.
3. Code stuff, fix bugs, make spaghetti, etc.
4. In the terminal from the root of the project, run `./bin/dev_sync.sh`.
   Personally, I'd recommend hooking this up so that it runs every time you save
   a file in the repo.

## Environment Variables

| Variable                 | Description                                       |
|:-------------------------|:--------------------------------------------------|
| `ACF_JSON_TRACKED_DIR`   | Your local copy of the project repository.        |
| `ACF_JSON_MU_PLUGIN_DIR` | The `mu-plugins` directory.                       |
