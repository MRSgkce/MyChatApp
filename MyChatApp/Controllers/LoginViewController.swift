//
//  ViewController 2.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 15.02.2025.
//


import UIKit

class LoginViewController: UIViewController {
    // MARK: Properties
    
    
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "ellipsis.message")
        imageView.tintColor = .white
        return imageView
    }()
    
    private var viewModel = loginViewModel()
        
    
    private lazy var emailContainerView : AuthInputView = {
        let containerView = AuthInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        
        return containerView
    }()
    
    private let emailTextField = CustomtextField(placeholder: "email")
    private var stackView = UIStackView()
    
    private lazy var passwordContainerView : AuthInputView = {
        let containerView = AuthInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        
        return containerView
    }()
    
    private let passwordTextField = CustomtextField(placeholder: "password")
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemCyan
        button.isEnabled = false
        return button

    }()
     
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureGradientLayer()
        style()
        layout()

    }
}


// MARK: -Selector

extension LoginViewController{
    
    @objc private func handletextfield(_ sender: UITextField){
        if sender == emailTextField {
            viewModel.emailTextField = sender.text
        }else{
            viewModel.passwordTextField = sender.text
        }
        loginButtonStatus()
    }
}
extension LoginViewController{
    private func loginButtonStatus(){
        if viewModel.status{
            loginButton.isEnabled=true
            loginButton.backgroundColor = .systemBlue
        }else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = .black
        }
    }
    
    
        private func style(){
            logoImageView.translatesAutoresizingMaskIntoConstraints = false
            emailContainerView.translatesAutoresizingMaskIntoConstraints = false
            stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView,loginButton])
            stackView.axis = .vertical//dikey
            stackView.spacing = 14
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.distribution = .fillEqually
            //email/password
            emailTextField.addTarget(self, action: #selector(handletextfield), for: .editingChanged)
            passwordTextField.addTarget(self, action: #selector(handletextfield), for: .editingChanged)
        }
        
        private func layout(){
            view.addSubview(logoImageView)
            view.addSubview(stackView)
            NSLayoutConstraint.activate([
                logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                logoImageView.heightAnchor.constraint(equalToConstant: 150),
                logoImageView.widthAnchor.constraint(equalToConstant: 150),
                logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
                stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
                stackView.heightAnchor.constraint(equalToConstant: 180)

            
            
            ])
        }
        
        
    }
