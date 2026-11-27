# Pigs Revenge 2: iOS port

An unofficial port of the Android game *Pigs Revenge 2* (AA games, 2016, GameMaker Studio 1.4) to iOS, built entirely in GitHub Actions.

## Pipeline

1. **`data/`**: original game data (`game.droid`), external music, icon and splash from the APK.
2. **Decompile** (`.github/workflows/decompile.yml`): builds UndertaleModTool and exports code (GML), sprites, textures, sounds and metadata (`tools/ExportMeta.csx`) to the `export` branch.
3. **Convert** (`tools/convert.py`, run locally): rebuilds a modern GameMaker project in `project/PigsRevenge2` from the export:
   ```
   git worktree add ../export origin/export
   python3 tools/convert.py ../export data project
   ```
   GMS1 code that used numeric sprite/sound indices is kept as is and translated at runtime (`__S`, `__SR`, `__A` in `scripts/__compat`). GMS1 views become camera calls, `#` in strings becomes a newline, and the Chartboost ad and in-app-purchase calls are stubbed out.
4. **Build** (`.github/workflows/build-ios.yml`): Igor (GameMaker CLI) creates the Xcode project on a macOS runner, `xcodebuild` makes an **unsigned** `.ipa`, and the result is published to the `latest` release.

Needs the repository secret `ACCESS_KEY` (GameMaker access key).

## Installing

Download `PigsRevenge2.ipa` from the **latest** release and install it with [Sideloadly](https://sideloadly.io) using your Apple ID. With a free Apple ID the app must be re-installed every 7 days.
