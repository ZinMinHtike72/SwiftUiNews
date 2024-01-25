//
//  NetworkManager.swift
//  SwiftNews
//
//  Created by ZMH Sabahna on 12/21/23.
//

import Foundation
import Alamofire
import SwiftyJSON
struct  NetworkManager {
    static let instance : NetworkManager = NetworkManager()
    
    func get(path : URL, completor : @escaping (JSON?,Bool) -> Void){
        AF.request(path, method: .get)
               .responseJSON { response in
                   print("From Networkmanager \(response)")
                   switch response.result {
                   case .success(let value):
                       let json = JSON(value)
                       if(!json["error"].boolValue){
                           completor(json,false)
                       }else{
                           completor(nil,true)
                       }
                   case .failure(let error):
                       print("Error fetching data: \(error)")
                       completor(nil, true)
                   }
           }
    }
}
