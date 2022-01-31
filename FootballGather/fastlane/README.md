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

### ios ut

```sh
[bundle exec] fastlane ios ut
```

Runs the unit tests of FootballGather

### ios ui

```sh
[bundle exec] fastlane ios ui
```

Runs the UI tests of FootballGather

### ios screenshots

```sh
[bundle exec] fastlane ios screenshots
```

Takes screenshots

### ios build_release_app

```sh
[bundle exec] fastlane ios build_release_app
```

Creates the release build

### ios distribute_release_app

```sh
[bundle exec] fastlane ios distribute_release_app
```

Distributes IPA to AppStore

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
