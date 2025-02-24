//
//  newMessageViewController.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 24.02.2025.
//

import UIKit
import Foundation

private let reuseIdentifier = "usercell"
class newMessageViewController: UIViewController {
    
    
    private let tableView = UITableView()
    private var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        service.fetchUsers {  users in
            self.users = users
            self.tableView.reloadData()
            
            
        }
    }
    
}

extension newMessageViewController {
    private func style(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(usercell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

extension newMessageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! usercell
        cell.backgroundColor = .systemGray6
        return cell
    }
}
