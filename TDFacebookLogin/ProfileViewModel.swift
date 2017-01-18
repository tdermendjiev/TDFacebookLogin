//
//  ProfileViewModel.swift
//  TDFacebookLogin
//
//  Created by Teodor Dermendzhiev on 1/18/17.
//  Copyright © 2017 Teodor Dermendzhiev. All rights reserved.
//

import Foundation

class ProfileViewModel: ViewModel {
    private(set) var state: ViewModelState = .Idle
    var willUpdateData: ((ProfileViewModel) -> Void)? = nil
    var didUpdateData: ((ProfileViewModel) -> Void)? = nil
    var user: User?
    
    func update() {
        MainAPI.sharedInstance.fetchCurrentUserData(completion: { (success) in
            if !success {
                print("Failed to update user data")
            }
            self.state = .Loading
            guard let user = StorageInteractor.fetchFromStorage(type: User.self).first as? User else {
                self.willUpdateData?(self)
                self.state = .Error
                self.didUpdateData?(self)
                return
            }
            
            self.willUpdateData?(self)
            self.user = user
            self.state = .Idle
            self.didUpdateData?(self)
        })
        
    }

}
