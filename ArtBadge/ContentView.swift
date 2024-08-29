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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        //    .background(Color.yellow)
            .navigationTitle("Печать магнита")
        }
        .navigationViewStyle(StackNavigationViewStyle())
      //  .background(Color.yellow)
    //    .edgesIgnoringSafeArea(.all)    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

