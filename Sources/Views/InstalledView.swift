import SwiftUI

struct InstalledView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    CloverHeader(eyebrow: "On this device", title: "Installed", subtitle: "Keep track of your Clover-managed apps.")

                    ContentUnavailableView {
                        Label("Nothing Installed Yet", systemImage: "checkmark.app")
                    } description: {
                        Text("Apps will appear here after installation management is implemented.")
                    }

                    GlassCard {
                        Label {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Installation engine").font(.headline)
                                Text("Not configured").font(.subheadline).foregroundStyle(.secondary)
                            }
                        } icon: {
                            Image(systemName: "gearshape.2.fill").foregroundStyle(.secondary)
                        }
                    }
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
