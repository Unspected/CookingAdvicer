import SwiftUI

enum SegmentedMenu: String, CaseIterable {
    case ingredients
    case instruction

}

struct MealDetailSegmented: View {
    
    let mealDetail: MealDetail
    @State var selectedTab: SegmentedMenu = .ingredients
    
    var body: some View {
        
        VStack(spacing: 0) {
            Picker("Menu", selection: $selectedTab) {
                ForEach(SegmentedMenu.allCases, id: \.rawValue) { option in
                    Text(option.rawValue.capitalized).tag(option)
                    
                }
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .pickerStyle(.segmented)
            
            switch selectedTab {
            case .ingredients:
                ingredients
            case .instruction:
                beatifyInstruction(instruction: mealDetail.instructions)
            }
            
        }
    }
    
    private var ingredients: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(mealDetail.ingredients, id: \.id) { ingredient in
                    HStack {
                        Text(ingredient.name)
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                        Text(ingredient.measure)
                            .font(.subheadline)
                            .fontWeight(.regular)
                        
                    }
                    .padding()
                    Divider()
                
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            
        }
        .scrollIndicators(.hidden)
      
    }
    
    private func beatifyInstruction(instruction: String) -> some View {
        let splitInstruction = instruction.components(separatedBy: ".")
        
        return ScrollView {
            VStack(alignment: .center) {
                Text(instruction)
                    .font(.headline)
            }
            .padding(30)
        }
        .scrollIndicators(.hidden)
    }
    
}

#Preview {
    MealDetailSegmented(mealDetail: MealDetail(
        name: "Spicy Arrabiata Penne",
        thumb: URL(string: "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg")!,
        instructions: "Bring a large pot of water to a boil. Add kosher salt to the boiling water, then add the pasta,",
        ingredients: [MealDetail.Ingredient(id: 1, name: "penne rigate", measure: "1 pound")]))
}
