//
//  RegisterViewController.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 18.02.2025.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseStorage

class RegisterViewController: UIViewController {
    // MARK: -PROPERTİES
    private var profileImageToUpload : UIImage?
    private var viewModel = RegisterViewModel()

    private let addCamera : UIButton = {
        let buton = UIButton(type: .system)
        buton.tintColor = .white
        buton.setImage(UIImage(systemName: "camera.circle"), for: .normal)
        buton.contentVerticalAlignment = .fill
        buton.contentHorizontalAlignment = .fill
        buton.translatesAutoresizingMaskIntoConstraints = false
        buton.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
        return buton
    }()
    
    private lazy var emailContainerView : AuthInputView = {
        let containerView = AuthInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        
        return containerView
    }()
    private let emailTextField = CustomtextField(placeholder: "email")
    
    
    private lazy var nameContainerView : AuthInputView = {
        let containerView = AuthInputView(image: UIImage(systemName: "person")!, textField: nameTextField)
        
        return containerView
    }()
    private let nameTextField = CustomtextField(placeholder: "name")
    
    private lazy var userNameContainerView : AuthInputView = {
        let containerView = AuthInputView(image: UIImage(systemName: "person")!, textField: userNameTextField)
        
        return containerView
    }()
    
    private let userNameTextField = CustomtextField(placeholder: "username")
    
    private lazy var passwordContainerView : AuthInputView = {
        let containerView = AuthInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        
        return containerView
    }()

    
    
    
    private let passwordTextField = CustomtextField(placeholder: "password")

    var stackView=UIStackView()
    
    private lazy var registerButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemCyan
        button.isEnabled = false
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
        
        return button

    }()
    
    private lazy var GologinPage:UIButton = {
        
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "if you are a member, return login page", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoTologin), for: .touchUpInside)
        
        return button
        
        
    }()
    
   
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        configureSetupKeyboard()
        configureGradientLayer()
        self.navigationController?.navigationBar.isHidden = true
        
    }
}
//MARK: - Selector
extension RegisterViewController {
    
    @objc private func handleRegisterButton(_ sender: UIButton){
        guard let emailText = emailTextField.text else{return}
        guard let nameText = nameTextField.text else{return}
        guard let userNameText = userNameTextField.text else{return}
        guard let passwordText = passwordTextField.text else{return}
        guard let profileImage = profileImageToUpload else {
            print("Profil resmi seçilmedi!")
            return
        }
        let user =  AuthenticationServiceUser(emailText: emailText,passwordText: passwordText, nameText: nameText,usernameText: userNameText)
        self.showProgressHUD(showProgress: true)
        AuthenticationService.register(withUser: user, image: profileImage) { error in
            if let error = error{
                print("error : \(error.localizedDescription)")
                self.showProgressHUD(showProgress: false)
                return
            }
            self.showProgressHUD(showProgress: false)
            self.dismiss(animated: true)
        }

        }
    
    
    @objc private func handletextfield(_ sender: UITextField){
        if sender == emailTextField {
            viewModel.email = sender.text
        }else if sender == nameTextField{
            viewModel.name = sender.text
        }else if sender == userNameTextField{
            viewModel.username = sender.text
        }else{
            viewModel.password = sender.text
        }
        registerButtonStatus()
    }
    @objc private func handleGoTologin(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
   private func registerButtonStatus(){
        if viewModel.status{
            registerButton.isEnabled=true
            registerButton.backgroundColor = .systemBlue
        }else{
            registerButton.isEnabled = false
            registerButton.backgroundColor = .black
        }
    }
    
   
    
    
    @objc private func handlePhoto(_ sender: UIButton){
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker,animated: true)
    }
    
   
    
    @objc private func keyboardNot(notification: NSNotification) {
        // Klavye açıldığında çalışacak fonksiyon
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            // Yalnızca view kaydırılacaksa kaydırma işlemi yapılacak
            if self.view.frame.origin.y == 0 { // Kaydırma yapılmamışsa
                self.view.frame.origin.y = -keyboardHeight / 2
            }
        }
        print("Klavye açıldı")
    }

    @objc private func keyboardhide() {
        // Klavye kapanırken ekranı eski haline döndür
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        print("Klavye kapandı")
    }


}


extension RegisterViewController {
    private func configureSetupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNot), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardhide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    private func style(){
     
        configureSetupKeyboard()
        view.backgroundColor = .blue
        //stackView = UIStackView(arrangedSubviews: [emailContainerView,nameContainerView,usernameContainerView ,passwordContainerView, registerButton])
              
        stackView = UIStackView(arrangedSubviews: [emailContainerView,nameContainerView,userNameContainerView, passwordContainerView,registerButton])
        stackView.axis = .vertical//dikey
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually


        
        emailTextField.addTarget(self, action: #selector(handletextfield), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handletextfield), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(handletextfield), for: .editingChanged)
       userNameTextField.addTarget(self, action: #selector(handletextfield), for: .editingChanged)
        GologinPage.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        view.addSubview(addCamera)
        view.addSubview(stackView)
        view.addSubview(GologinPage)
        
        NSLayoutConstraint.activate([
            addCamera.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addCamera.heightAnchor.constraint(equalToConstant: 150),
            addCamera.widthAnchor.constraint(equalToConstant: 150),
            addCamera.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: addCamera.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.heightAnchor.constraint(equalToConstant: 250),
            
            
            GologinPage.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            GologinPage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: GologinPage.trailingAnchor,constant: 32)
        ])
    }
}


extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            self.profileImageToUpload = image
            addCamera.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            addCamera.layer.cornerRadius = 150/2
            addCamera.clipsToBounds = true
            addCamera.layer.borderColor = UIColor.white.cgColor
            addCamera.layer.borderWidth = 2
            addCamera.contentMode = .scaleAspectFill
            dismiss(animated: true)
        }else{
            print("Görsel seçilemedi.")
        }
    }
    
    
}
