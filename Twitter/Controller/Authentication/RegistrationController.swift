//
//  RegistrationController.swift
//  Twitter
//
//  Created by Wagner Barboza Goulart on 14/07/22.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
    private var imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
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
    
    private lazy var registrationButton: UIButton = {
        let button = Utilities().loginButton(withTitle: "Sign Up")
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Log In")
        button.addTarget(self, action: #selector(handleNavigateToLogin), for: .touchUpInside)
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
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleRegistration(){
        guard let profileImage = profileImage else {
            print("DEBUG: Please, select a profile image...")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let username = fullnameTextField.text else { return }
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            guard let uid = result?.user.uid else { return }
            let values = ["email": email, "username": username, "fullname": fullname]
            
            REF_USER.child(uid).updateChildValues(values) { (errors, ref) in
                print("DEBUG: Successfully updated user information...")
            }
        }
    }
    
    @objc func handleNavigateToLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        navigationController?.navigationBar.barStyle = .black
        navigationItem.setHidesBackButton(true, animated: true)

        
        view.addSubview(uploadProfilePhoto)
        uploadProfilePhoto.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        uploadProfilePhoto.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView,
                                                  fullnameContainerView, usernameContainerView,
                                                  registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: uploadProfilePhoto.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingTop: 20, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor, paddingLeft: 40, paddingBottom: 16,
                                     paddingRight: 40)
    }
}

//MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        uploadProfilePhoto.layer.cornerRadius = 150 / 2
        uploadProfilePhoto.layer.masksToBounds = true
        uploadProfilePhoto.imageView?.contentMode = .scaleAspectFill
        uploadProfilePhoto.imageView?.clipsToBounds = true
        uploadProfilePhoto.layer.borderColor = #colorLiteral(red: 0.9808574388, green: 1, blue: 0.9557514828, alpha: 1)
        uploadProfilePhoto.layer.borderWidth = 3
        self.uploadProfilePhoto.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
