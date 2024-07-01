import SwiftUI

struct CategoryListView: View {
    
    let categoryTitle: TypeCategory
    @StateObject var viewModel: CategoryListViewModel
    
    init(categoryTitle: TypeCategory, service: MealServiceProtocol) {
        self.categoryTitle = categoryTitle
        _viewModel = .init(wrappedValue: CategoryListViewModel(mealService: service))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Divider()
                HStack(alignment: .bottom) {
                    Text(categoryTitle.rawValue.capitalized)
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink {
                        SelectedCategoryView(categoryType: categoryTitle)
                    } label: {
                        Text("See All")
                            .font(.headline)
                            .foregroundStyle(Color.black.opacity(0.5))
                    }
                }
                
                Divider()
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10) {
                        ForEach(viewModel.meals, id: \.id) { model in
                            NavigationLink {
                                MealDetailView(id: model.id, manager: DI.mealManager)
                            } label: {
                                MealView(model: model)
                                    .frame(width: 220, height: 220)
                            }
                        }
                    }
                }
            }
        }
        .task {
           await viewModel.fetchMeals(category: categoryTitle)
        }
     }
    }

#Preview {
    CategoryListView(categoryTitle: .beef, service: MealService())
  
}
