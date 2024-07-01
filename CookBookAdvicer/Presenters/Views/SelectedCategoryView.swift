import SwiftUI

struct SelectedCategoryView: View {
    
    @StateObject var viewModel: SelectedCategoryViewModel
    let categoryType: TypeCategory
    
    let gridItem = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(categoryType: TypeCategory, service: MealServiceProtocol = MealService()) {
        self.categoryType = categoryType
        _viewModel = .init(wrappedValue: SelectedCategoryViewModel(mealService: service))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItem) {
                    ForEach(viewModel.meals, id: \.id) { model in
                        NavigationLink {
                            MealDetailView(id: model.id, manager: MealService())
                        } label: {
                            MealView(model: model)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle(categoryType.rawValue.capitalized)
        }
        .padding()
        .task(priority: .background) {
            await viewModel.fetchMeals(category: categoryType)
        }
    }
}

#Preview {
    SelectedCategoryView(categoryType: .beef, service: MealService())
}
