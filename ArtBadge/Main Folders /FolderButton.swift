import SwiftUI

struct FolderButton: View {
    var label: String
    var systemImage: String
    var destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 5) {
                Image(systemName: systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text(label)
                    .font(.headline)
                    .lineLimit(1)
                    .frame(width: 120)
                    .truncationMode(.tail)
            }
            .frame(width: 80)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
