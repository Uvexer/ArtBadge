import SwiftUI

struct FolderButtons: View {
    var body: some View {
        VStack {

            HStack(spacing: 200) {
                FolderButton(
                    label: "Города",
                    systemImage: "folder",
                    destination: AnyView(CitiesView())
                )
                
                FolderButton(
                    label: "Твое фото",
                    systemImage: "folder",
                    destination: AnyView(CustomCameraView())
                )
                
                FolderButton(
                    label: "Фото с почты",
                    systemImage: "folder",
                    destination: AnyView(MailPhotoView())
                )
            }
        }
        .padding()
    }
}
