import SwiftUI
import AVFoundation

struct CustomCameraView: View {
    @StateObject private var cameraViewModel = CameraViewModel()
    @State private var capturedImage: UIImage? = nil
    @State private var showImageView = false
    
    var body: some View {
        ZStack {
            CameraPreview(session: cameraViewModel.session)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        cameraViewModel.takePhoto { image in
                            self.capturedImage = image
                            self.showImageView = true
                        }
                    }) {
                        Image(systemName: "camera.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.bottom, 20)
            }
            .background(
                NavigationLink(
                    destination: ImageView(image: capturedImage),
                    isActive: $showImageView,
                    label: {
                        Text("")
                    }
                )
            )
        }
        .onAppear {
            cameraViewModel.configure()
        }
        .onDisappear {
            cameraViewModel.stopSession()
        }
        .navigationBarHidden(true)
    }
}

struct ImageView: View {
    var image: UIImage?

    @State private var isEnlargedImageViewPresented = false
    @State private var selectedImage: IdentifiableUIImage?

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .ignoresSafeArea()

                Button("Далее") {
                    selectedImage = IdentifiableUIImage(image: image)
                    isEnlargedImageViewPresented = true
                }
                .font(.system(size: 24))
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .fullScreenCover(item: $selectedImage) { image in
                    EnlargedImageView(selectedImage: image)
                }
            } else {
                Text("No image captured")
                    .foregroundColor(.red)
            }
            Spacer()
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    var session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = .portrait
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var session = AVCaptureSession()
    private var output = AVCapturePhotoOutput()
    
    func configure() {
        checkPermissions()
        setupSession()
    }
    
    private func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if !granted {}
            }
        case .denied, .restricted:
            return
        default:
            break
        }
    }
    
    private func setupSession() {
        session.beginConfiguration()
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input) {
                session.addInput(input)
            }
        } catch {
            print("Error setting device input: \(error)")
            return
        }
        
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        
        session.commitConfiguration()
        session.startRunning()
    }
    
    func takePhoto(completion: @escaping (UIImage?) -> Void) {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
        self.completion = completion
    }
    
    func stopSession() {
        session.stopRunning()
    }
    
    private var completion: ((UIImage?) -> Void)?
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else {
            completion?(nil)
            return
        }
        let image = UIImage(data: imageData)
        completion?(image)
    }
}
