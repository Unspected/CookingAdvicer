import SwiftUI

struct CategoriesView: View {

    @StateObject var viewModel: CategoriesViewModel
    
    init(service: CategoryServiceProtocol) {
        _viewModel = .init(wrappedValue: CategoriesViewModel(service: service))
    }

    let gridItem = [GridItem(), GridItem()]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 25) {
                        ForEach(viewModel.categories, id: \.id) { model in
                            CategoryListView(
                                categoryTitle: model.type,
                                service: DI.mealManager)
                            .padding()
                        }
                    }
                }
                .task(priority: .high) {
                    await viewModel.fetchCategories()
                    await viewModel.fetchCategoriesV2()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(L10n.welcomeTitle)
                        .font(.title3)
                }
            }
            .background(.beige)
    }
   
}

}

#Preview {
    CategoriesView(service: CategoryService())
}
