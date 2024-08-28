import SwiftUI

struct MailPhotoView: View {
    var body: some View {
        Text("Здесь будут фото с почты")
            .font(.largeTitle)
            .navigationTitle("Фото с почты")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
    }
}
