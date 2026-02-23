fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ut

```sh
[bundle exec] fastlane ut
```

Runs the unit tests of FootballGather

### ui

```sh
[bundle exec] fastlane ui
```

Runs the UI tests of FootballGather

### distribute_release_app

```sh
[bundle exec] fastlane distribute_release_app
```

Distributes IPA to AppStore

### bump_versions

```sh
[bundle exec] fastlane bump_versions
```

Bumps the app versions

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
