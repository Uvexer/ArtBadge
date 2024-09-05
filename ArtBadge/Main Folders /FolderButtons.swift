import SwiftUI

struct FolderButtons: View {
    var body: some View {
        VStack {

            HStack(spacing: 200) {
                FolderButton(
                    label: "Фото городов",
                    systemImage: "folderr",
                    destination: AnyView(CitiesView())
                )
                
                FolderButton(
                    label: "Камера",
                    systemImage: "folderr",
                    destination: AnyView(CustomCameraView())
                )
                
                FolderButton(
                    label: "Фото с почты",
                    systemImage: "folderr",
                    destination: AnyView(MailPhotoView())
                )
            }
        }
        .padding()
    }
}
