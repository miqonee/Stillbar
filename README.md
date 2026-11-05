# Stillbar

Stillbar is a Windows 11 taskbar application with a media player and optional island-style taskbar appearance. [Stillbar Media](https://github.com/miqonee/Stillbar-Media) is the companion browser extension.

## Status

Stillbar 0.7.0 is a pre-release. The browser extension has been submitted to Opera Add-ons. Its store installation flow and the store extension ID have not been verified end to end. Browser-independent media sources use Windows media sessions.

## Build

Windows 11 x64, Visual Studio 2022 C++ Build Tools and Windows SDK 26100 are required.

```powershell
.\build.ps1
```

The script writes a timestamped directory under `dist`. Run `Stillbar.exe` from that directory. Keep the executable, `Stillbar.Core.dll`, `Stillbar.BrowserHost.exe` and `browser-extension` together. Settings are stored in `settings.ini` beside the application.

`browser-extension/` is a pinned developer-mode snapshot needed by the current app's test setup. The extension's source of record and store package live in [Stillbar Media](https://github.com/miqonee/Stillbar-Media). The snapshot contains a public test key for a stable developer ID; it contains no private signing key.

## Releases

GitHub Actions builds the app on pushes and pull requests and retains a ZIP as a workflow artifact. Pushing a tag such as `v0.7.0` that exactly matches `STILLBAR_VERSION_STRING` in `src/version.hpp` creates a **draft** GitHub release with the ZIP and SHA-256 file attached. The owner can inspect and publish the draft. The application does not yet check for or install updates automatically.

The build ZIP is an unsigned pre-release application. It does not include user settings or logs. For the store integration, the actual published extension URL and installed ID must be verified and configured before creating a release that advertises one-click installation.

## License

[MIT](LICENSE).
