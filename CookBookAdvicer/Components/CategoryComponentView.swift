import SwiftUI
import CachedAsyncImage

struct CategoryComponentView: View {

    let model: Category
    @State var isOnScreen = false

    var body: some View {
        
        ZStack(alignment: .bottom) {
            if isOnScreen {
                CachedAsyncImage(url: model.thumb) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    ProgressView()
                }
            }
            HStack(alignment: .bottom) {
                Text(model.type.rawValue)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.leading, 20)
                Spacer()

            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.5).clipShape(RoundedRectangle(cornerRadius: 20)))
        }
        .background().clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear {
            isOnScreen = true
        }
        .onDisappear {
            isOnScreen = false
        }
    }
}

#Preview {
    CategoryComponentView(
        model: Category(
            id: "1",
            type: .beef,
            thumb: URL(string: "https://www.themealdb.com/images/category/beef.png"),
            description: ""))
    .background(Color.white)
}
