//
//  HomeViewController.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 23.02.2025.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    //MARK: -Properties
    private var messageButton : UIBarButtonItem!
    private var newmessageButton : UIBarButtonItem!
    private var container = Container()
    private let viewControllers: [UIViewController] = [messageViewController(),newMessageViewController()]

    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signOut()
        
      
        style()
        layout()
    }
}

//MARK: -Helpers
extension HomeViewController {
    private func configureNavigateItemBar(text: String, selector: Selector)->UIButton{
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    private func authenticationStatus(){
        if Auth.auth().currentUser?.uid == nil{
            DispatchQueue.main.async {
                let controller = UINavigationController(rootViewController: LoginViewController())
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }
        }
    }
    private func signOut() {
        do {
            try Auth.auth().signOut()
            authenticationStatus()
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    private func style() {
        view.backgroundColor = .red
        messageButton = UIBarButtonItem(customView: configureNavigateItemBar(text: "Message", selector: #selector(handlemessagebutton)))
        
        newmessageButton = UIBarButtonItem(customView: configureNavigateItemBar(text: "NewMessage", selector: #selector(handlenewmessagebutton)))
        self.navigationItem.leftBarButtonItems = [messageButton,newmessageButton]
        configureContainer()
        handlemessagebutton()
    }
    private func layout () {
 
    }
    
    private func configureContainer(){
        guard  let containerView = container.view else{return}
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController{
    
    @objc func handlemessagebutton(){
        if self.container.children.first == messageViewController() { return}
        self.container.add(viewControllers[0])
        
        self.viewControllers[0].view.alpha = 0
        UIView.animate(withDuration: 1) {
            self.messageButton.customView?.alpha = 1
            self.newmessageButton.customView?.alpha = 0.5
            self.viewControllers[0].view.alpha = 1
            self.viewControllers[1].view.frame.origin.x = -1000
            
            
        }completion: { _ in
            self.viewControllers[1].remove()
            self.viewControllers[1].view.frame.origin.x = 0
        }
        
    }
    
    @objc func handlenewmessagebutton(){
        
        if self.container.children.first == newMessageViewController() { return}
        self.container.add(viewControllers[1])
        self.viewControllers[1].view.alpha = 0
        UIView.animate(withDuration: 1) {
            self.messageButton.customView?.alpha = 0.5
            self.newmessageButton.customView?.alpha = 1
            self.viewControllers[1].view.alpha = 1
            self.viewControllers[0].view.frame.origin.x = +1000
            
            
        }completion: { _ in
            self.viewControllers[0].remove()
            self.viewControllers[0].view.frame.origin.x = 0
        }
        
    }
    
}
