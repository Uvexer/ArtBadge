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
