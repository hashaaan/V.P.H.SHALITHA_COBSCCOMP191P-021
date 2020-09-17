//
//  SignInViewController.swift
//  NIBM COVID19
//
//  Created by HASHAN on 8/25/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back_black"), for: .normal)
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        return button
    }()
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.text = "Sign In with Email"
        label.font = UIFont(name: "Avenir-Light", size: 30)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(textField: emailTextField )
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false, keyBoard: .emailAddress, caps: UITextAutocapitalizationType.none)
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private let signinButton: AuthUIButton = {
        let button = AuthUIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    private let signupPageButton: UIButton = {
        let button = UIButton(type: .system)
        let buttonTitle = NSMutableAttributedString(string: "Don't have an account?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.gray])
        button.addTarget(self, action: #selector(showSignUpPage), for: .touchUpInside)
        button.setAttributedTitle(buttonTitle, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleSignIn() {
       guard let email = emailTextField.text else { return }
       guard let password = passwordTextField.text else { return }
       
       Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
           if let error = error {
               print("DEBUG: Faild to log user with error \(error.localizedDescription)")
               return
           }
           
           let keyWindow = UIApplication.shared.connectedScenes
           .filter({$0.activationState == .foregroundActive})
           .map({$0 as? UIWindowScene})
           .compactMap({$0})
           .first?.windows
           .filter({$0.isKeyWindow}).first
           
           guard let controller = keyWindow?.rootViewController as? MainTabBarController else { return }
           controller.configTabBar()
           
           self.dismiss(animated: true, completion: nil)
       }
    }
    
    @objc func showSignUpPage() {
        let view = SignUpViewController()
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Function
    
    func configUI() {
        configNavBar()
        
        view.backgroundColor = .white
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 40, height: 40)
        view.addSubview(titleLbl)
        titleLbl.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        titleLbl.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, signinButton, signupPageButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16)
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }

}
