import SwiftUI

struct FolderButtons: View {
    var body: some View {
        HStack(spacing: 20) {
            FolderButton(
                label: "Города",
                systemImage: "folder.fill", 
                destination: AnyView(CitiesView())
            )
            
            FolderButton(
                label: "Твое фото",
                systemImage: "folder.fill",
                destination: AnyView(YourPhotoView())
            )
            
            FolderButton(
                label: "Фото с почты",
                systemImage: "folder.fill",
                destination: AnyView(MailPhotoView())
            )
        }
    }
}

