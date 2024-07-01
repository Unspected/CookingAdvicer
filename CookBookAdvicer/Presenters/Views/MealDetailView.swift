import SwiftUI

struct MealDetailView: View {
    
    let id: String
    @StateObject var viewModel: MealDetailViewModel
    @Environment(\.dismiss) var dismiss
    @State var selectTab: SegmentedMenu = .ingredients
    
    init(id: String, manager: MealServiceProtocol) {
        self.id = id
        _viewModel = .init(wrappedValue: MealDetailViewModel(service: manager))
    }
    
    var body: some View {
            VStack {
                
                switch viewModel.state {
                case .initial, .loading:
                    ProgressView()
                case .loaded(let mealDetail):
                   
                        mealDetailPreview(mealDetail)
                            .customBackButton()
                        MealDetailSegmented(mealDetail: mealDetail)
                    
                case .failed(let error):
                    Text(error.localizedDescription)
                }
            
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.getMealDetails(id)
        }
        .ignoresSafeArea()
        .background(Color.beige)
    }
    
    @ViewBuilder
    private func mealDetailPreview(_ model: MealDetail) -> some View {
            DishImageNutritions(
                imageURL: model.thumb,
                dishName: model.name,
                nutritions: NutritionFacts(calories: 100, protein: 5, fat: 5, carbs: 5))
    }
}

#Preview {
    MealDetailView(id: "52878", manager: MealService())
}
