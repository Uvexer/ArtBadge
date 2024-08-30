import SwiftUI
import SafariServices

struct MailPhotoView: View {
    @State private var savedURL: URL?

    var body: some View {
        VStack {
            if let savedURL = savedURL {
                MailWebView(url: savedURL)
                    .edgesIgnoringSafeArea(.all)
                    .navigationTitle("Фото с почты")
            } else {
                MailWebView(url: URL(string: "https://mail.google.com/mail/u/0/#inbox")!) { url in
                    saveURL(url)
                }
                .edgesIgnoringSafeArea(.all)
                .navigationTitle("Фото с почты")
            }
        }
        .onAppear {
            loadSavedURL()
        }
    }

    private func saveURL(_ url: URL) {
        UserDefaults.standard.set(url.absoluteString, forKey: "SavedMailURL")
        savedURL = url
    }

    private func loadSavedURL() {
        if let urlString = UserDefaults.standard.string(forKey: "SavedMailURL"),
           let url = URL(string: urlString) {
            savedURL = url
        }
    }
}
