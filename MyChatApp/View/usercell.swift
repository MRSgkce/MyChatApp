//
//  usercell.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 24.02.2025.
//

import UIKit
import Foundation

class usercell: UITableViewCell {
    
    var user: User? {
        didSet {
            configureUserCell()
        }
    }
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "title name"
        return label
    }()
    
    private let subtitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray
        label.text = "subtitle name"
        return label
    }()
    
    private var stackView = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension usercell{
    private func setup(){
        //profileimageview
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 60/2
        
        //stackview
        stackView = UIStackView(arrangedSubviews: [title, subtitle])
        stackView.axis = .vertical
        //stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout(){
    addSubview(profileImageView)
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            //stackview
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 4),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4)
        
       ])
    
        }
    
    private func configureUserCell(){
        
    }
}
