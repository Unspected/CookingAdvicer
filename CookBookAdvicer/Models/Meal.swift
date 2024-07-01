import Foundation

struct MealsSelectedCategory: Decodable {
    let meals: [Meal]
}

struct Meal: Identifiable, Decodable {
    let id: String
    let name: String
    let thumb: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumb = "strMealThumb"
    }
}
