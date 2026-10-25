
import SwiftUI

enum CloverTheme {
    static let accent = Color(red: 0.42, green: 0.38, blue: 0.98)
    static let secondaryAccent = Color(red: 0.24, green: 0.68, blue: 0.98)
    static let background = Color(uiColor: .systemGroupedBackground)
}

enum CloverTab: String, CaseIterable, Identifiable {
    case discover = "Discover"
    case sources = "Sources"
    case installed = "Installed"
    case settings = "Settings"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .discover: "sparkles"
        case .sources: "square.stack.3d.up.fill"
        case .installed: "checkmark.square.fill"
        case .settings: "gearshape.fill"
        }
    }
}

struct ContentView: View {
    @State private var selection: CloverTab = .discover

    var body: some View {
        ZStack {
            CloverTheme.background
                .ignoresSafeArea()

            Group {
                switch selection {
                case .discover:
                    DiscoverView()
                case .sources:
                    SourcesView()
                case .installed:
                    InstalledView()
                case .settings:
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            CloverTabBar(selection: $selection)
                .padding(.horizontal, 14)
                .padding(.top, 8)
                .padding(.bottom, 5)
                .background {
                    LinearGradient(
                        colors: [
                            CloverTheme.background.opacity(0),
                            CloverTheme.background.opacity(0.3)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea(edges: .bottom)
                }
        }
    }
}

struct CloverTabBar: View {
    @Binding var selection: CloverTab

    var body: some View {
        HStack(spacing: 4) {
            ForEach(CloverTab.allCases) { tab in
                Button {
                    withAnimation(.snappy(duration: 0.22)) {
                        selection = tab
                    }
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: tab.symbol)
                            .font(.system(size: 21, weight: .semibold))
                            .frame(height: 25)

                        Text(tab.rawValue)
                            .font(.system(size: 11, weight: .semibold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .foregroundStyle(
                        selection == tab
                            ? CloverTheme.accent
                            : Color.primary.opacity(0.65)
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .contentShape(Rectangle())
                    .background {
                        if selection == tab {
                            RoundedRectangle(
                                cornerRadius: 18,
                                style: .continuous
                            )
                            .fill(CloverTheme.accent.opacity(0.15))
                            .modifier(
                                SelectedTabGlassEffect()
                            )
                        }
                    }
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(
                    selection == tab ? .isSelected : []
                )
            }
        }
        .padding(6)
        .background {
            RoundedRectangle(
                cornerRadius: 25,
                style: .continuous
            )
            .fill(.clear)
            .modifier(TabBarGlassEffect())
        }
        .shadow(
            color: .black.opacity(0.12),
            radius: 18,
            x: 0,
            y: 7
        )
    }
}

struct TabBarGlassEffect: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .glassEffect(.regular, in: .rect(cornerRadius: 25))
                .overlay {
                    RoundedRectangle(
                        cornerRadius: 25,
                        style: .continuous
                    )
                    .strokeBorder(
                        Color.primary.opacity(0.10),
                        lineWidth: 0.7
                    )
                }
        } else {
            content
                .background(.ultraThinMaterial, in: RoundedRectangle(
                    cornerRadius: 25,
                    style: .continuous
                ))
                .overlay {
                    RoundedRectangle(
                        cornerRadius: 25,
                        style: .continuous
                    )
                    .strokeBorder(
                        Color.primary.opacity(0.12),
                        lineWidth: 1
                    )
                }
        }
    }
}

struct SelectedTabGlassEffect: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .glassEffect(
                    .regular.tint(CloverTheme.accent.opacity(0.25)),
                    in: .rect(cornerRadius: 18)
                )
        } else {
            content
        }
    }
}

struct GlassCard<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
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
        VStack(alignment: .leading, spacing: 6) {
            Text(eyebrow.uppercased())
                .font(.caption.weight(.bold))
                .tracking(1.4)
                .foregroundStyle(CloverTheme.accent)

            Text(title)
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)
                .minimumScaleFactor(0.8)
                .lineLimit(1)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 8)
    }
}
