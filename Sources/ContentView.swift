import SwiftUI

struct ContentView: View {
    @State private var selection: CloverTab = .discover

    var body: some View {
        Group {
            if #available(iOS 18.0, *) {
                nativeTabView
            } else {
                legacyTabView
            }
        }
        .tint(CloverTheme.accent)
    }

    @available(iOS 18.0, *)
    private var nativeTabView: some View {
        TabView(selection: $selection) {
            Tab(
                "Discover",
                systemImage: "sparkles",
                value: CloverTab.discover
            ) {
                DiscoverView()
            }

            Tab(
                "Sources",
                systemImage: "square.stack.3d.up.fill",
                value: CloverTab.sources
            ) {
                SourcesView()
            }

            Tab(
                "Installed",
                systemImage: "checkmark.square.fill",
                value: CloverTab.installed
            ) {
                InstalledView()
            }

            Tab(
                "Settings",
                systemImage: "gearshape.fill",
                value: CloverTab.settings
            ) {
                SettingsView()
            }
        }
    }

    private var legacyTabView: some View {
        TabView(selection: $selection) {
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "sparkles")
                }
                .tag(CloverTab.discover)

            SourcesView()
                .tabItem {
                    Label(
                        "Sources",
                        systemImage: "square.stack.3d.up.fill"
                    )
                }
                .tag(CloverTab.sources)

            InstalledView()
                .tabItem {
                    Label(
                        "Installed",
                        systemImage: "checkmark.square.fill"
                    )
                }
                .tag(CloverTab.installed)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(CloverTab.settings)
        }
    }
}
