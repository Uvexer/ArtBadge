import SwiftUI

struct FolderButton: View {
    var label: String
    var systemImage: String
    var destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 5) {
                Image("folderr")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text(label)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .frame(width: 120)
                    .truncationMode(.tail)
            }
            .frame(width: 80)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
