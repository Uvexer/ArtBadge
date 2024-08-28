import SwiftUI

struct CitiesView: View {
    let images = ["city1", "city2", "city3", "city4"]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .padding()
        }
        .navigationTitle("Города")
    }
}
