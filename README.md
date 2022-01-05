This CLI allows an easy start to Flutter projects following SCP Architecture.

## Features

- Directory structure generation.
- Dependency inclusion.
- Project template generation.

## Getting started

1. Activate this program with `pub`:
  - `dart pub global activate -s git https://github.com/h80r/scp8.git`
2. Add _pub-cache_ to your path :
  - `export PATH="$PATH":"$HOME/.pub-cache/bin"`

## Usage

### Basic command

```bash
scp
```
With this command you will be guided to configure the desired project and it'll be generated.

### Fast Start

```bash
scp -f
```
This command uses a default configuration for your project, needing only the project name.

## Additional information

### Updating

To update your program, simply run `dart pub global activate -s git https://github.com/h80r/scp8.git` again.

### `scp -f` directory structure

```
sample_project
├── analysis_options.yaml
├── android
│   └── [...]
├── .dart_tool
│   └── [...]
├── .gitignore
├── .idea
│   └── [...]
├── ios
│   └── [...]
├── lib
│   ├── canvas
│   │   ├── components
│   │   │   └── .gitkeep
│   │   ├── .gitkeep
│   │   └── home.dart
│   ├── main.dart
│   ├── provider
│   │   ├── canvas
│   │   │   ├── .gitkeep
│   │   │   └── home.dart
│   │   └── .gitkeep
│   ├── schema
│   │   ├── enums
│   │   │   └── .gitkeep
│   │   ├── .gitkeep
│   │   └── home.dart
│   └── utils
│       └── .gitkeep
├── linux
│   └── [...]
├── .metadata
├── .packages
├── pubspec.lock
├── pubspec.yaml
├── README.md
├── sample_project.iml
├── test
│   └── [...]
└── web
    └── [...]
```
