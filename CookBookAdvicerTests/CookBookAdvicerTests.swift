import XCTest
@testable import CookBookAdvicer

private struct MockMealService: MealServiceProtocol {
    
    let decoder: JSONDecoder
    
    public struct Ingredient: Decodable, Hashable {
        let id: Int
        let name: String
        let measure: String
    }
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    func fetchMeals(category: TypeCategory) async throws -> [Meal] {
        return [Meal(id: "1", name: "\(category.rawValue)", thumb: URL(string: "")),
                Meal(id: "2", name: "Beef stroganoff", thumb: nil),
                Meal(id: "3", name: "Russian Borsch", thumb: nil),
                Meal(id: "4", name: "Chicken alfredo", thumb: nil),
                Meal(id: "5", name: "Salad Cesar", thumb: URL(string: "https://www.themealdb.com/images/media/meals/wrssvt1511556563.jpg"))
        ]
    }
    
    func fetchMealDetail(id: String) async throws -> MealDetail? {
        let mockJSON = """
        {
            "id": "\(id)"
            "name": "Mock Meal",
            "thumb": "https://example.com/mock_thumb.jpg",
            "strInstructions": "These are mock instructions for preparing the meal.",
            "strIngredient1": "Mock Ingredient 1",
            "strMeasure1": "1 cup",
            "strIngredient2": "Mock Ingredient 2",
            "strMeasure2": "2 tbsp",
            "strIngredient3": "Mock Ingredient 3",
            "strMeasure3": "3 slices"
        }
        """
        if let data = mockJSON.data(using: .utf8) {
            let mockDetail = try decoder.decode(MealDetail.self, from: data)
            return mockDetail
        } else {
            return nil
        }
        
    }
     
}

final class CookBookAdvicerTests: XCTestCase {
    
    private var networkService: NetworkProtocol!
    private var mockMealService: MockMealService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkService = NetworkService()
        mockMealService = MockMealService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkService = nil
    }

    func test_getting_meals() async throws {
        var viewModel = await SelectedCategoryViewModel(mealService: mockMealService)
        
        await viewModel.fetchMeals(category: .beef)
        
        let meals = await viewModel.meals
        
        XCTAssertNotNil(meals, "request isn't complete \(meals) must not empty")
        XCTAssertEqual(meals.count, 5, "must be 5")
        
    }
    
    

}
