import SwiftUI

struct SourcesView: View {
    @AppStorage("clover.sourceURLs") private var storedURLs = ""
    @State private var showingAddSource = false
    @State private var newURL = ""

    private var urls: [String] {
        storedURLs.split(separator: "\n").map(String.init).filter { !$0.isEmpty }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    CloverHeader(eyebrow: "Catalogs", title: "Sources", subtitle: "Manage the repositories you trust.")

                    GlassCard {
                        HStack(spacing: 12) {
                            Image(systemName: "square.stack.3d.up.fill")
                                .font(.title2).foregroundStyle(CloverTheme.accent)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Your repositories").font(.headline)
                                Text("\(urls.count) saved source\(urls.count == 1 ? "" : "s")")
                                    .font(.subheadline).foregroundStyle(.secondary)
                            }
                            Spacer()
                            Button { showingAddSource = true } label: {
                                Image(systemName: "plus")
                                    .font(.headline)
                                    .frame(width: 38, height: 38)
                                    .background(CloverTheme.accent.opacity(0.13), in: Circle())
                            }
                            .accessibilityLabel("Add source")
                        }
                    }

                    if urls.isEmpty {
                        ContentUnavailableView {
                            Label("No Sources Yet", systemImage: "tray")
                        } description: {
                            Text("Add a repository URL to keep it in your source list. Live repository loading will be added next.")
                        } actions: {
                            Button("Add Source") { showingAddSource = true }
                                .buttonStyle(.borderedProminent)
                        }
                    } else {
                        ForEach(urls, id: \.self) { url in
                            GlassCard {
                                HStack(alignment: .top, spacing: 12) {
                                    Image(systemName: "globe").foregroundStyle(CloverTheme.accent)
                                    Text(url).font(.subheadline).textSelection(.enabled)
                                    Spacer()
                                    Button(role: .destructive) {
                                        storedURLs = urls.filter { $0 != url }.joined(separator: "\n")
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .accessibilityLabel("Remove source")
                                }
                            }
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: 760)
                .frame(maxWidth: .infinity)
            }
            .background(CloverTheme.background)
            .toolbar(.hidden, for: .navigationBar)
            .sheet(isPresented: $showingAddSource) {
                NavigationStack {
                    Form {
                        Section("Repository URL") {
                            TextField("https://example.com/repo.json", text: $newURL)
                                .keyboardType(.URL)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                        }
                        Section {
                            Text("This saves the URL locally only. Clover does not fetch or install apps from it yet.")
                                .font(.footnote).foregroundStyle(.secondary)
                        }
                    }
                    .navigationTitle("Add Source")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { showingAddSource = false }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                let trimmed = newURL.trimmingCharacters(in: .whitespacesAndNewlines)
                                guard let url = URL(string: trimmed), ["https", "http"].contains(url.scheme?.lowercased() ?? ""), url.host != nil else { return }
                                if !urls.contains(trimmed) {
                                    storedURLs = (urls + [trimmed]).joined(separator: "\n")
                                }
                                newURL = ""
                                showingAddSource = false
                            }
                            .disabled(!isValidURL)
                        }
                    }
                }
                .presentationDetents([.medium, .large])
            }
        }
    }

    private var isValidURL: Bool {
        let trimmed = newURL.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: trimmed) else { return false }
        return ["https", "http"].contains(url.scheme?.lowercased() ?? "") && url.host != nil
    }
}
