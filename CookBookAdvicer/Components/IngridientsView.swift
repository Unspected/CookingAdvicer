import SwiftUI

//struct IngredientInfo {
//    let name: String
//    let measure: String
//    let thumb: String?
//}

//struct IngridientsView: View {
//    
//    let listOfIngredients: [Ingredient]
//    
//    var body: some View {
//        ScrollView(showsIndicators: false) {
//            HStack {
//                Image(.grocery)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 60, height: 60)
//                Text(L10n.ingredientTitle.capitalized)
//                    .fontWeight(.heavy)
//                    .font(.title)
//            }
//            .padding(25)
//          
//            LazyVStack {
//                ForEach(listOfIngredients, id: \.name) { ingredient in
//                    ingredientCell(ingredient)
//                    Divider()
//                }
//            }
//            .frame(maxWidth: .infinity)
//            
//        }
//    }
//    
//    @ViewBuilder
//    private func ingredientCell(_ ingredientInfo: Ingredient) -> some View {
//        HStack {
//            Text(ingredientInfo.measure)
//                .foregroundStyle(Color.black.opacity(0.5))
//                .frame(maxWidth: .infinity)
//            Image(getImageFromString(ingredientInfo.thumb ?? "none"))
//                .resizable()
//                .scaledToFit()
//                .frame(width: 35, height: 35)
//                .frame(maxWidth: .infinity)
//            Text(ingredientInfo.name)
//                .frame(maxWidth: .infinity)
//        }
//        
//    }
//    
//    private func getImageFromString(_ imgName: String) -> ImageResource {
//        ImageResource(name: imgName, bundle: Bundle.main)
//    }
//}

//#Preview {
//    IngridientsView(
//        listOfIngredients: [
//            IngredientInfo(name: "Flour", measure: "1/2 cup", thumb: "flour"),
//            IngredientInfo(name: "Beef", measure: "1 kg", thumb: "meat"),
//            IngredientInfo(name: "Salt", measure: "1 tbs", thumb: "salt")
//        ])
//}
