import SwiftUI

struct DemoApp: Identifiable {
    let id: String
    let name: String
    let subtitle: String
    let symbol: String
    let category: String
}

struct DiscoverView: View {
    private let featured = [
        DemoApp(id: "orbit", name: "Orbit Player", subtitle: "A cleaner way to explore audio", symbol: "waveform", category: "MEDIA"),
        DemoApp(id: "pixel", name: "Pixel Notes", subtitle: "Notes, sketches and quick ideas", symbol: "scribble.variable", category: "PRODUCTIVITY"),
        DemoApp(id: "atlas", name: "Atlas Browser", subtitle: "A focused browsing concept", symbol: "safari", category: "UTILITIES")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    CloverHeader(eyebrow: "Your app space", title: "Discover", subtitle: "A home for the apps you choose.")

                    GlassCard {
                        HStack(spacing: 14) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 17).fill(
                                    LinearGradient(colors: [CloverTheme.accent, CloverTheme.secondaryAccent],
                                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                Image(systemName: "leaf.fill")
                                    .font(.system(size: 27, weight: .semibold))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 64, height: 64)
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Welcome to Clover")
                                    .font(.headline)
                                Text("Your sideloading workspace is taking shape.")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }

                    HStack {
                        Text("Featured concepts").font(.title3.bold())
                        Spacer()
                        Text("DEMO").font(.caption2.bold()).tracking(1)
                            .padding(.horizontal, 9).padding(.vertical, 5)
                            .background(.secondary.opacity(0.12), in: Capsule())
                            .foregroundStyle(.secondary)
                    }

                    ForEach(featured) { app in
                        GlassCard {
                            HStack(spacing: 14) {
                                Image(systemName: app.symbol)
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundStyle(CloverTheme.accent)
                                    .frame(width: 54, height: 54)
                                    .background(CloverTheme.accent.opacity(0.12), in: RoundedRectangle(cornerRadius: 15))
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(app.name).font(.headline)
                                    Text(app.subtitle).font(.subheadline).foregroundStyle(.secondary)
                                    Text(app.category).font(.caption2.weight(.bold)).tracking(1)
                                        .foregroundStyle(CloverTheme.accent).padding(.top, 3)
                                }
                                Spacer(minLength: 0)
                                Image(systemName: "arrow.up.right")
                                    .font(.caption.weight(.bold))
                                    .foregroundStyle(.tertiary)
                            }
                        }
                    }

                    Text("These are sample cards, not downloadable apps yet.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(20)
                .frame(maxWidth: 760)
                .frame(maxWidth: .infinity)
            }
            .background(CloverTheme.background)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
