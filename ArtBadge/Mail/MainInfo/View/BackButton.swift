import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            withAnimation {
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            Text("Назад")
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 150, height: 50)
                .background(Color.blue.opacity(0.9))
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .padding(.top, 20)
    }
}
