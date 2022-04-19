//
//  FeedViewController.swift
//  Navigation
//
//  Created by Igor Situn on 19.04.2022.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Лента"
        let button = UIButton(frame: CGRect(x: 300, y: 500, width: 150, height: 100))
        view.addSubview(button)
        button.setTitle("Открыть пост", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
    
    @objc func buttonClicked() {
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
}

struct NewPostForView {
    let title:String = "Новый топик"
}
