import Foundation
import SwiftyJSON

struct CategoryModel : Identifiable{
    let id : String
    let name : String
    
    init(json : JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
    }
}
