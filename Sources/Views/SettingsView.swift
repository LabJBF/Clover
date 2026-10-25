
import SwiftUI

struct SettingsView: View {
    @AppStorage("clover.appearance") private var appearance = "system"

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    CloverHeader(
                        eyebrow: "Preferences",
                        title: "Settings",
                        subtitle: "Make Clover feel like yours."
                    )

                    GlassCard {
                        VStack(alignment: .leading, spacing: 14) {
                            Label(
                                "Appearance",
                                systemImage: "circle.lefthalf.filled"
                            )
                            .font(.headline)

                            Picker("Appearance", selection: $appearance) {
                                Text("System").tag("system")
                                Text("Light").tag("light")
                                Text("Dark").tag("dark")
                            }
                            .pickerStyle(.segmented)
                        }
                    }

                    GlassCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Label(
                                "About Clover",
                                systemImage: "leaf.fill"
                            )
                            .font(.headline)

                            LabeledContent("Version", value: "0.1.0")
                            LabeledContent("Minimum iOS", value: "17.0")
                            LabeledContent("Build", value: "Foundation")
                        }
                    }

                    GlassCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Mac.Clover")
                                .font(.headline)

                            Text("Built as an independent sideloading project.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            Text("Signing and installation features are not yet implemented.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
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
