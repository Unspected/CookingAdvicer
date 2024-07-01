import SwiftUI
import CachedAsyncImage

struct MealView: View {
    
    let model: Meal
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
                Text(model.name)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
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
    MealView(model: Meal(id: "1", name: "Beef Banh Mi Bowls with Sriracha Mayo, Carrot & Pickled Cucumber", thumb: URL(string: "https://www.themealdb.com/images/media/meals/z0ageb1583189517.jpg")!))
}
