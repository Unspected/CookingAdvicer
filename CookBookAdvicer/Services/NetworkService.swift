import Foundation

enum APIEndPoint {
    case categories
    case categoriesV2
    case selectedCategory(selectedCategory: TypeCategory)
    case searchMealByName(name: String)
    case mealDetail(id: String)

    var url: URL {
        switch self {
        case .categories: URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!
        case .selectedCategory(selectedCategory: let category):
            URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=\(category)")!
        case .searchMealByName(name: let name):
            URL(string: "www.themealdb.com/api/json/v1/1/search.php?s=\(name)")!
        case .mealDetail(id: let id):
            URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        case .categoriesV2:
            URL(string: "http://127.0.0.1:8000/categories")!
            
        }
    }
}

enum ServiceErrors: Error, LocalizedError {
    case internalError(_ statusCode: Int)
    case serverError(_ statusCode: Int)
}

protocol NetworkProtocol {
    func fetchData<T: Decodable>(_ url: APIEndPoint) async throws -> T where T: Decodable
}

final class NetworkService: NetworkProtocol {
    
    private let decoder: JSONDecoder
    private let urlSession: URLSession
    
    init(decoder: JSONDecoder = JSONDecoder(), urlSession: URLSession = .shared) {
        self.decoder = decoder
        self.urlSession = urlSession
    }
    
    func fetchData<T>(_ url: APIEndPoint) async throws -> T where T: Decodable {
        let (data, response) = try await urlSession.data(from: url.url)
        
        try? mapResponse(response: response)
        
        let result = try decoder.decode(T.self, from: data)
        return result
    }
    
    // Handle Error
    private func mapResponse(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            return
        }
        switch httpResponse.statusCode {
        case (400...499):
            throw ServiceErrors.internalError(httpResponse.statusCode)
        default:
            throw ServiceErrors.serverError(httpResponse.statusCode)
        }
    }
}
