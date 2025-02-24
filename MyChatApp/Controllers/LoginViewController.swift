//
//  ViewController 2.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 15.02.2025.
//


import UIKit
import JGProgressHUD

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
    
    private let passwordTextField: CustomtextField = {
        let textField = CustomtextField(placeholder: "password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    
    
    private lazy var loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemCyan
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button

    }()
    
    private lazy var switchToRegister:UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "click to become a member", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoToRegister), for: .touchUpInside)
        
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
    
    @objc private func handleLogin(_ sender: UIButton){
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        showProgressHUD(showProgress: true)
       AuthenticationService.login(withEmail: email,password: password){ result, error in
            if let error = error{
                print("error : \(error.localizedDescription)")
                self.showProgressHUD(showProgress: false)
                return
            }
           self.showProgressHUD(showProgress: false)
            self.dismiss(animated: true)}
        
      
        
    }
    
    @objc private func handletextfield(_ sender: UITextField){
        if sender == emailTextField {
            viewModel.emailTextField = sender.text
        }else{
            viewModel.passwordTextField = sender.text
        }
        loginButtonStatus()
    }
    
    
    @objc private func handleGoToRegister(_ sender: UIButton){
        let controller = RegisterViewController()
        self.navigationController?.pushViewController(controller, animated: true)
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
    
    // switchToRegister
    switchToRegister.translatesAutoresizingMaskIntoConstraints = false
        }
        
        private func layout(){
            view.addSubview(logoImageView)
            view.addSubview(stackView)
            view.addSubview(switchToRegister)
            NSLayoutConstraint.activate([
                logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                logoImageView.heightAnchor.constraint(equalToConstant: 150),
                logoImageView.widthAnchor.constraint(equalToConstant: 150),
                logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
                stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
                stackView.heightAnchor.constraint(equalToConstant: 180),
                
                switchToRegister.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
                switchToRegister.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                view.trailingAnchor.constraint(equalTo: switchToRegister.trailingAnchor,constant: 32)

            
            
            ])
        }
        
        
    }
