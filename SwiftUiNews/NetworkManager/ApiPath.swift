import Foundation

struct ApiPath{
    static let BasePath : String = "https://swiftnews.cyclic.app/api/v1/mobile/"
    static let CategoriesPath : String = "categories"
}

enum ApiStatus{
   case processing
   case completed
   case failure
}
