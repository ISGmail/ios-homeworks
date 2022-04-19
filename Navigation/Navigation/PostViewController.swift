//
//  PostViewController.swift
//  Navigation
//
//  Created by Igor Situn on 19.04.2022.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        let newPost = NewPostForView()
        let titleLabel = UILabel()
        titleLabel.text = newPost.title
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        let infoButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(buttonInfoClicked))
        navigationItem.rightBarButtonItem = infoButton
    }
    @objc func buttonInfoClicked() {
        let infoViewController = InfoViewController()
        navigationController?.pushViewController(infoViewController, animated: true)
    }

}
