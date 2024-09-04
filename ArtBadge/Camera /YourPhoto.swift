import SwiftUI
import AVFoundation

struct CustomCameraView: View {
    @StateObject private var cameraViewModel = CameraViewModel()
    @State private var capturedImage: UIImage? = nil
    @State private var showEnlargedImageView = false
    
    @Environment(\.dismiss) var dismiss  
    
    var body: some View {
        ZStack {
            CameraPreview(session: cameraViewModel.session)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .padding()
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        cameraViewModel.takePhoto { image in
                            self.capturedImage = image
                            self.showEnlargedImageView = true
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
                    destination: EnlargedImageView(uiImage: capturedImage, imageName: nil),
                    isActive: $showEnlargedImageView,
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
        .navigationBarBackButtonHidden(true)
    }
}

