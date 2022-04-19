//
//  InfoViewController.swift
//  Navigation
//
//  Created by Igor Situn on 19.04.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        title = "Информация"
        let button = UIButton(frame: CGRect(x: 130, y: 770, width: 150, height: 40))
        view.addSubview(button)
        button.setTitle("Показать алерт", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(alertClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
    @objc func alertClicked() {
        let alert = UIAlertController(title: "Предупреждение!", message: "Тестовый мессадж", preferredStyle: .alert)
        let firstButton = UIAlertAction(title: "Первое", style: .default, handler: nil)
        let secondButton = UIAlertAction(title: "Второе", style: .destructive, handler: nil)
        alert.addAction(firstButton)
        alert.addAction(secondButton)
        present(alert, animated: true, completion: nil)
        print("сообщение в консоль.")
    }
       
}
    
