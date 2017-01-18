//
//  AuthenticationRouter.swift
//  TDFacebookLogin
//
//  Created by Teodor Dermendzhiev on 1/18/17.
//  Copyright © 2017 Teodor Dermendzhiev. All rights reserved.
//

import Foundation
import UIKit

class AuthenticationRouter {
    static func instantiateInitialViewController() -> AuthenticationViewController {
        let viewController = UIStoryboard(name: "Authentication", bundle: nil).instantiateInitialViewController()
        let vc: AuthenticationViewController = viewController as! AuthenticationViewController
        return vc
    }
}
