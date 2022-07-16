//
//  RegistrationController.swift
//  Twitter
//
//  Created by Wagner Barboza Goulart on 14/07/22.
//

import UIKit

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var uploadProfilePhoto: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "plus_photo").withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleUploadPhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: fullnameTextField)
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: usernameTextField)
        return view
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = Utilities().loginButton(withTitle: "Sign Up")
        button.addTarget(self, action: #selector(handleCreateAccount), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var fullnameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Full name")
        tf.autocapitalizationType = .words
        return tf
    }()
    
    private lazy var usernameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Username")
        return tf
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleUploadPhoto(){
        print("DEBUG: Upload photo...")
    }
    
    @objc func handleCreateAccount(){
        print("DEBUG: Creating account...")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(uploadProfilePhoto)
        uploadProfilePhoto.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        uploadProfilePhoto.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView,
                                                  fullnameContainerView, usernameContainerView,
                                                  createAccountButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: uploadProfilePhoto.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingTop: 20, paddingLeft: 32, paddingRight: 32)
        
        
        
        
    }
}
