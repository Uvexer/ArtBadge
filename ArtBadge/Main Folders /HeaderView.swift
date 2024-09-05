import SwiftUI

struct HeaderView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}

