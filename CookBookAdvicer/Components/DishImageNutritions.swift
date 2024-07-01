import SwiftUI

// https://ltdfoto.ru/images/2024/04/23/berry_Pie-1.jpg

struct NutritionFacts {
    let calories: Int
    let protein: Int
    let fat: Int
    let carbs: Int
}

struct DishImageNutritions: View {
    
    let imageURL: URL?
    let dishName: String
    let nutritions: NutritionFacts
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedCorner(radius: 90, corners: [.topLeft, .topRight]))
                    .padding()

            } placeholder: {
                ProgressView()
            }
                nutritionsDetail(dishName, details: nutritions)
                .offset(y: -40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .compositingGroup()
        .clipShape(RoundedCorner(radius: 75.0, corners: [.topLeft, .topRight]))
    }
    
    @ViewBuilder
    private func nutritionsDetail(_ name: String, details: NutritionFacts) -> some View {
        VStack(alignment: .leading) {
            Text(name)
                .foregroundStyle(Color(.white))
                .fontWeight(.bold)
                .font(.largeTitle)
                .shadow(color: .black, radius: 2)
            HStack {
                Text(L10n.nutritionDetails)
                    .fontWeight(.heavy)
                Text("\(details.calories)/\(details.protein)/\(details.fat)/\(details.carbs)")
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15.0).fill(Color(.white)))
            .foregroundStyle(Color(.backgroundNutritions))
        }
    }
}

#Preview {
    DishImageNutritions(imageURL: URL(string: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")!,
                        dishName: "Berry Pie",
                        nutritions: NutritionFacts(calories: 150, protein: 5, fat: 3, carbs: 25))
}
