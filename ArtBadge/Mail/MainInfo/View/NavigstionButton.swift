import SwiftUI

struct NavigationButtonView: View {
    var body: some View {
        NavigationLink(destination: MailPhotoView()) {
            Text("Далее")
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 150, height: 50)
                .background(Color.blue.opacity(0.9))
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .padding()
    }
}
