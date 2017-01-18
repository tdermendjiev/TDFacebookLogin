//
//  MainAPI.swift
//  TDFacebookLogin
//
//  Created by Teodor Dermendzhiev on 1/18/17.
//  Copyright © 2017 Teodor Dermendzhiev. All rights reserved.
//

import Foundation

class MainAPI: NSObject {
    static let sharedInstance = MainAPI()
    private let persistencyManager: PersistencyManager
    
    private override init() {
        persistencyManager = PersistencyManager()
    }
    
    func fetchCurrentUserData(completion: @escaping (Bool) -> ()) {
        FBDataInteractor.getFBUserInfo { (user) in
            guard let user = user else {
                completion(false)
                return
            }
            self.persistencyManager.saveUserData(user: user, completion: { (success) in
                completion(success)
            })
        }
    }
    
    func logout() {
        persistencyManager.deleteUser()
    }
}
