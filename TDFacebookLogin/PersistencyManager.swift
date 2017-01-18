//
//  PersistencyManager.swift
//  TDFacebookLogin
//
//  Created by Teodor Dermendzhiev on 1/18/17.
//  Copyright © 2017 Teodor Dermendzhiev. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class PersistencyManager: NSObject {
    
    let realm = try! Realm()
    
    override init() {
        super.init()
    }
    
    func saveUserData(user: [String: AnyObject], completion: @escaping (Bool) ->()) {
        
        let json = JSON(user)
        print(user)
        guard let avatarURL = json["picture"]["data"]["url"].string,
            let coverURL = json["cover"]["source"].string,
            let gender = json["gender"].string,
            let firstName = json["first_name"].string,
            let lastName = json["last_name"].string,
            let userId = json["id"].string else {
                
                completion(false)
                return
                
        }
        
        let userDict = [
            "firstName" : firstName,
            "lastName" : lastName,
            "gender" : gender,
            "avatarURL" : avatarURL,
            "coverURL" : coverURL,
            "userId" : userId
        ] as [String : Any]

        StorageInteractor.writeToStorage(type: User.self, data: userDict, update: true)
        completion(true)
    }
    
    func deleteUser() {
        StorageInteractor.deleteFromStorage(type: User.self)
    }
}
