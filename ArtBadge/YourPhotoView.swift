import SwiftUI
import UniformTypeIdentifiers

struct YourPhotoView: View {
    @State private var image: UIImage? = nil

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } else {
                Text("Фото не получено")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            }
        }
        .navigationTitle("Твое фото")
        .onOpenURL { url in
            handleIncomingURL(url)
        }
    }

    func handleIncomingURL(_ url: URL) {
        guard url.startAccessingSecurityScopedResource() else { return }
        defer { url.stopAccessingSecurityScopedResource() }

        do {
            let data = try Data(contentsOf: url)
            if let uiImage = UIImage(data: data) {
                image = uiImage
                saveToPhotoLibrary(uiImage)
            }
        } catch {
            print("Ошибка при загрузке изображения: \(error.localizedDescription)")
        }
    }
    
    
    func saveToPhotoLibrary(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

