//
//  FBDataInteractor.swift
//  TDFacebookLogin
//
//  Created by Teodor Dermendzhiev on 1/18/17.
//  Copyright © 2017 Teodor Dermendzhiev. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class FBDataInteractor {
    static func getFBUserInfo(completion: @escaping ([String:AnyObject]?) -> ()) {
        
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"first_name, last_name, email, picture.type(large), cover, name, gender, id"])
        request?.start(completionHandler: { (_, result, error) -> Void in
            
            if ((error) != nil) {
                print("Error: \(error)")
            }
            else {
                completion(result as? [String:AnyObject])
            }
        })
    }
}
