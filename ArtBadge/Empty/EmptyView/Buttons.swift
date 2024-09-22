import SwiftUI

struct ButtonsView: View {
    var dismissAction: () -> Void
    var printAction: () -> Void

    var body: some View {
        HStack(spacing: 150) {
            Button(action: dismissAction) {
                Text("Назад")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: printAction) {
                Text("Печать")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
