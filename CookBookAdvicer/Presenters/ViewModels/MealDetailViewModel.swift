import Foundation

protocol GetMealDetailsProtocol {
    func getMealDetails(_ id: String) async
}

@MainActor
final class MealDetailViewModel: ObservableObject, GetMealDetailsProtocol {
    
    // Public
    enum ViewModelError: LocalizedError {
        case mealNotFound
        
        var errorDescription: String? {
            switch self {
            case .mealNotFound: "Meal not found"
            }
        }
    }
    
    enum ViewState {
        case initial
        case loading
        case loaded(MealDetail)
        case failed(Error)
        
        var shouldFetch: Bool {
            switch self {
            case .initial, .failed: true
            case .loading, .loaded: false
            }
        }
    }
    
    @Published var state: ViewState = .initial
    
    private let service: MealServiceProtocol
    @Published var mealDetail: MealDetail?
    
    init(service: MealServiceProtocol = MealService()) {
        self.service = service
    }
    
    deinit {
        print("❌ \(self)")
    }
    
    func getMealDetails(_ id: String) async {
        
        guard state.shouldFetch else {
            return
        }
        state = .loading
        
        do {
            let mealDetail = try await service.fetchMealDetail(id: id)
            try Task.checkCancellation()
            if let mealDetail {
                self.state = .loaded(mealDetail)
                self.mealDetail = mealDetail
            } else {
                self.state = .failed(ViewModelError.mealNotFound)
            }
        } catch {
            self.state = .failed(error)
        }
    }
    
}
