import SwiftUI

enum CloverTheme {
    static let accent = Color(red: 0.42, green: 0.38, blue: 0.98)
    static let secondaryAccent = Color(red: 0.24, green: 0.68, blue: 0.98)
    static let background = Color(uiColor: .systemGroupedBackground)
}

struct ContentView: View {
    @State private var selection: CloverTab = .discover

    var body: some View {
        TabView(selection: $selection) {
            DiscoverView()
                .tabItem { Label("Discover", systemImage: "sparkles") }
                .tag(CloverTab.discover)

            SourcesView()
                .tabItem { Label("Sources", systemImage: "square.stack.3d.up") }
                .tag(CloverTab.sources)

            InstalledView()
                .tabItem { Label("Installed", systemImage: "checkmark.app") }
                .tag(CloverTab.installed)

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
                .tag(CloverTab.settings)
        }
    }
}

enum CloverTab: Hashable {
    case discover, sources, installed, settings
}

struct GlassCard<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                if #available(iOS 26.0, *) {
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(.regularMaterial)
                        .overlay {
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                                .strokeBorder(.white.opacity(0.20), lineWidth: 1)
                        }
                } else {
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(Color(uiColor: .secondarySystemGroupedBackground))
                        .overlay {
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                                .strokeBorder(Color.primary.opacity(0.06), lineWidth: 1)
                        }
                }
            }
    }
}

struct CloverHeader: View {
    let eyebrow: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(eyebrow.uppercased())
                .font(.caption.weight(.bold))
                .tracking(1.4)
                .foregroundStyle(CloverTheme.accent)
            Text(title)
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 8)
    }
}
