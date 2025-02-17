//
//  textField.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 17.02.2025.
//

import UIKit
class CustomtextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        borderStyle = .none
        textColor = .white  // Metin rengini beyaz yapalım
        font = UIFont.systemFont(ofSize: 16) // Yazı boyutunu belirleyelim
        attributedPlaceholder = NSMutableAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
        translatesAutoresizingMaskIntoConstraints = false // Otomatik boyut ayarlarını etkinleştirelim
     

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
