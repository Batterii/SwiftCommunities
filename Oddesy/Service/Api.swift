//
//  Api.swift
//  Oddesy
//
//  Created by Anthony Kiniyalocts on 1/18/18.
//  Copyright © 2018 Anthony Kiniyalocts. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

public struct Base {
    static let index = "/index.json"
}

protocol BatteriiApi {
    func fetchIndex(name: String, complete: @escaping ( _ success: Bool, _ error: NSError? )->())
}

class Api : BatteriiApi{
    
    let decoder: JSONDecoder
    
    init(){
        self.decoder = JSONDecoder()
    }

    func fetchIndex(name: String, complete: @escaping (Bool, NSError?) -> ()) {
        
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        
        let url = "https://" + trimmedName + ".batterii.com" + Base.index
        
        Alamofire.request(url).validate().responseData { dataResponse in
            
            do{
                let indexResponse = try self.decoder.decode(IndexResponse.self, from: dataResponse.data!)
                
                let realm = try! Realm()
                
                try! realm.write {
                    realm.add(indexResponse.community, update: true)
                }
                complete(true, nil)
            }catch let error{
                complete(false, error as NSError)
            }
        }
    }
 
}
