import SwiftUI

struct FolderButton: View {
    var label: String
    var systemImage: String
    var destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            Label(label, systemImage: systemImage)
                .font(.title)
                .padding()
                .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

