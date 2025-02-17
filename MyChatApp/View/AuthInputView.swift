//
//  AuthInputView.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 17.02.2025.
//
import UIKit
import Foundation


class AuthInputView: UIView {
    init(image: UIImage, textField: UITextField) {
        super.init(frame: .zero)

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = image
        imageView.tintColor = .white

        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(textField)
        let divider = UIView()
        divider.backgroundColor = .white
        divider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(divider)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),

            textField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            trailingAnchor.constraint(equalTo: textField.trailingAnchor,constant: 8),

         //   heightAnchor.constraint(equalToConstant: 8), // Minimum yükseklik eklendi
            
            divider.heightAnchor.constraint(equalToConstant: 0.70),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
