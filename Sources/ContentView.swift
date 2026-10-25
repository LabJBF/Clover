import SwiftUI

enum CloverTheme {
    static let accent = Color(
        red: 0.42,
        green: 0.38,
        blue: 0.98
    )

    static let secondaryAccent = Color(
        red: 0.24,
        green: 0.68,
        blue: 0.98
    )

    static let background = Color(
        uiColor: .systemGroupedBackground
    )
}

enum CloverTab: String, CaseIterable, Identifiable {
    case discover = "Discover"
    case sources = "Sources"
    case installed = "Installed"
    case settings = "Settings"

    var id: String {
        rawValue
    }

    var symbol: String {
        switch self {
        case .discover:
            "sparkles"
        case .sources:
            "square.stack.3d.up.fill"
        case .installed:
            "checkmark.square.fill"
        case .settings:
            "gearshape.fill"
        }
    }
}

struct ContentView: View {
    @State private var selection: CloverTab = .discover

    var body: some View {
        TabView(selection: $selection) {
            DiscoverView()
                .tabItem {
                    Label(
                        CloverTab.discover.rawValue,
                        systemImage: CloverTab.discover.symbol
                    )
                }
                .tag(CloverTab.discover)

            SourcesView()
                .tabItem {
                    Label(
                        CloverTab.sources.rawValue,
                        systemImage: CloverTab.sources.symbol
                    )
                }
                .tag(CloverTab.sources)

            InstalledView()
                .tabItem {
                    Label(
                        CloverTab.installed.rawValue,
                        systemImage: CloverTab.installed.symbol
                    )
                }
                .tag(CloverTab.installed)

            SettingsView()
                .tabItem {
                    Label(
                        CloverTab.settings.rawValue,
                        systemImage: CloverTab.settings.symbol
                    )
                }
                .tag(CloverTab.settings)
        }
        .tint(CloverTheme.accent)
    }
}

struct GlassCard<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(16)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .background {
                RoundedRectangle(
                    cornerRadius: 22,
                    style: .continuous
                )
                .fill(.regularMaterial)
                .overlay {
                    RoundedRectangle(
                        cornerRadius: 22,
                        style: .continuous
                    )
                    .strokeBorder(
                        Color.primary.opacity(0.1),
                        lineWidth: 1
                    )
                }
            }
    }
}

struct CloverHeader: View {
    let eyebrow: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 6
        ) {
            Text(eyebrow.uppercased())
                .font(.caption.weight(.bold))
                .tracking(1.4)
                .foregroundStyle(CloverTheme.accent)

            Text(title)
                .font(
                    .system(
                        size: 34,
                        weight: .bold,
                        design: .rounded
                    )
                )
                .foregroundStyle(.primary)
                .minimumScaleFactor(0.8)
                .lineLimit(1)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(.top, 8)
    }
}

