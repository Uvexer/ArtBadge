import SwiftUI

struct ContentView: View {
    var body: some View {
            NavigationView {
                VStack {
                    Spacer()
                    HeaderView(text: "Давай выберем папку")
                        .offset(y: -200)
                    
                    FolderButtons()
                    
                    Spacer()
                }
                .navigationTitle("Печать магнита")
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }



#Preview {
    ContentView()
}
