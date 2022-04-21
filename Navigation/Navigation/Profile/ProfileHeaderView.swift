//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Igor Situn on 20.04.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    let imageView = UIImageView()
    let fullNameLabel = UILabel()
    let statusTextView = UITextView()
    let setStatusButton = UIButton()
    var statusTextField = UITextField()
    private var statusText: String = ""
    
    private func setupView() {
        
        imageView.backgroundColor = .green
        imageView.image = UIImage(named: "Cat.jpeg")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 55
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
          
        let constraintsForImage = [
            imageView.widthAnchor.constraint(equalToConstant: 110),
            imageView.heightAnchor.constraint(equalToConstant: 110),
            imageView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor)
        ]
        NSLayoutConstraint.activate(constraintsForImage)

        fullNameLabel.text = "Hipster cat"
        fullNameLabel.textColor = .black
        fullNameLabel.textAlignment = .center
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.addSubview(fullNameLabel)

        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraintsForTitle = [
            fullNameLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 27),
            fullNameLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            fullNameLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 120),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 30)
            ]
        NSLayoutConstraint.activate(constraintsForTitle)

        statusTextView.backgroundColor = .gray
        statusTextView.font = .systemFont(ofSize: 14)
        statusTextView.textColor = .systemGray5
        statusTextView.textAlignment = .center
        statusTextView.isEditable = false
        statusTextView.text = "Waiting for something..."
        self.addSubview(statusTextView)

        statusTextView.translatesAutoresizingMaskIntoConstraints = false
        let constraintsForTextView = [
            statusTextView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 100),
            statusTextView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            statusTextView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 120),
            statusTextView.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(constraintsForTextView)
        
        statusTextField.placeholder = "Ожидание..."
        statusTextField.adjustsFontSizeToFitWidth = true
        statusTextField.minimumFontSize = 0.5
        statusTextField.returnKeyType = .done
        statusTextField.autocapitalizationType = .words
        statusTextField.font = .systemFont(ofSize: 15)
        statusTextField.textColor = .systemGray2
        statusTextField.backgroundColor = .white
        statusTextField.borderStyle = .none
        statusTextField.returnKeyType = .next
        statusTextField.keyboardType = .default
        statusTextField.clearButtonMode = .always
        statusTextField.layer.cornerRadius = 7
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        self.addSubview(statusTextField)

        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        let constraintsForTextField = [
            statusTextField.topAnchor.constraint(equalTo: self.statusTextView.bottomAnchor, constant: 10),
            statusTextField.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            statusTextField.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 120),
            statusTextField.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(constraintsForTextField)
       
        setStatusButton.setTitle("Показать статус", for: .normal)
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(setStatusButton)
        
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        let constraintsForButton = [
            setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 10),
            setStatusButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            setStatusButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraintsForButton)

        }
        
    @objc func buttonPressed(sender: UIButton) {
         print(statusText)
         if statusText == "" {
             statusTextView.text = "Ожидание..."
         } else {
                 statusTextView.text = statusText
             }
         }

     @objc func statusTextChanged(_ textField: UITextField) {
         if let status = textField.text {
             statusText = status
         } else {
             statusText = ""
         }
     }
}
