import Foundation

struct CategoriesV2: Decodable {
    let categories: [CategoryV2]
}

struct CategoryV2: Decodable {
    let id: Int
    let name: String
    let thumb: URL
}

struct Categories: Decodable {
    let categories: [Category]
}

struct Category: Identifiable, Decodable {
    let id: String
    let type: TypeCategory
    let thumb: URL?
    let description: String

    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case type = "strCategory"
        case thumb = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}

enum TypeCategory: String, Decodable, CaseIterable {
    case beef
    case chicken
    case dessert
    case lamb
    case miscellaneous
    case pasta
    case pork
    case seafood
    case side
    case starter
    case vegan
    case vegetarian
    case breakfast
    case goat
    case none
    
    // Implement Decodable initializer to handle case-insensitive decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = TypeCategory(rawValue: rawValue.lowercased()) ?? .none
    }
}
