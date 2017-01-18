//
//  ProfileViewController.swift
//  TDFacebookLogin
//
//  Created by Teodor Dermendzhiev on 1/18/17.
//  Copyright © 2017 Teodor Dermendzhiev. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import SDWebImage
import SwiftyJSON
import Agrume

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var logoutButton: FBSDKLoginButton!
    
    fileprivate var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 3.0
        avatarImageView.layer.cornerRadius = 10.0
        
        logoutButton.delegate = self
        
        firstNameLabel.text = ""
        lastNameLabel.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (FBSDKAccessToken.current() != nil) {
            viewModel.didUpdateData = {(vm) in
                guard let user = vm.user else {
                    print("Failed to fetch user")
                    return
                }
                self.configureView(user: user)
            }
            viewModel.update()
        } else {
            presentAuthScreen()
        }
    }
    
    func configureView(user: User) {
        self.avatarImageView.sd_setImage(with: URL(string: user.avatarURL), placeholderImage: UIImage(named:"avatar_placeholder.png"))
        self.coverImageView.sd_setImage(with: URL(string: user.coverURL), placeholderImage: UIImage(named:"avatar_placeholder.png"))
        self.genderImageView.image = UIImage(named: user.gender)
        self.firstNameLabel.text = user.firstName
        self.lastNameLabel.text = user.lastName
    }
    
    func presentAuthScreen() {
        let loginVC = AuthenticationRouter.instantiateInitialViewController()
        self.present(loginVC, animated: true, completion: nil)
    }
    
    @IBAction func avatarTapped(_ sender: Any) {
        guard let image = avatarImageView.image else { return }
        let agrume = Agrume(image: image, backgroundColor: .black)
        agrume.showFrom(self)
    }
    
    
    @IBAction func coverTapped(_ sender: Any) {
        guard let image = coverImageView.image else { return }
        let agrume = Agrume(image: image, backgroundColor: .black)
        agrume.showFrom(self)
    }
    
}

extension ProfileViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        MainAPI.sharedInstance.logout()
        presentAuthScreen()
    }
}
