import SwiftUI
import PhotosUI


struct IdentifiableUIImage: Identifiable {
    let id = UUID()
    let image: UIImage
}

struct MailGalleryView: View {
    @State private var selectedImage: IdentifiableUIImage? = nil
    
    var body: some View {
        PhotoPicker(selectedImage: $selectedImage)
            .edgesIgnoringSafeArea(.all)
            .fullScreenCover(item: $selectedImage) { image in
                if let imageData = image.image.jpegData(compressionQuality: 1.0) {
                    let identifiableImage = IdentifiableImage(id: UUID(), name: "Selected Image", imageData: imageData)
                    EmptyView(selectedImage: identifiableImage)
                }
            }
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: IdentifiableUIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            if let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async {
                        if let uiImage = image as? UIImage {
                            self.parent.selectedImage = IdentifiableUIImage(image: uiImage)
                        }
                    }
                }
            }
        }
    }
}
