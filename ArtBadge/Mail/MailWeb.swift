import SwiftUI
import SafariServices

struct MailWebView: UIViewControllerRepresentable {
    let url: URL
    var onURLChange: ((URL) -> Void)?

    func makeUIViewController(context: Context) -> SFSafariViewController {
        onURLChange?(url)
        
        let safariVC = SFSafariViewController(url: url)
        return safariVC
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        var parent: MailWebView

        init(_ parent: MailWebView) {
            self.parent = parent
        }
    }
}
