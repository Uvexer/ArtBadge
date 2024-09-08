import SwiftUI

struct NavigationButtonView: View {
    var body: some View {
        NavigationLink(destination: MailPhotoView()) {
            Text("Далее")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
    }
}
