//
//  User.swift
//  TDFacebookLogin
//
//  Created by Teodor Dermendzhiev on 1/18/17.
//  Copyright © 2017 Teodor Dermendzhiev. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var avatarURL = ""
    dynamic var coverURL = ""
    dynamic var userId = ""
    dynamic var gender = ""
    
    override class func primaryKey() -> String? {
        return "userId"
    }
}
