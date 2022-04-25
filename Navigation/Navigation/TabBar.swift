//
//  TabBar.swift
//  Navigation
//
//  Created by Igor Situn on 19.04.2022.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVC()
    }
    
   fileprivate func createNavController(viewCtrl: UIViewController,
                                                        title: String,
                                                        image: UIImage) -> UIViewController {
       let item = UITabBarItem(title: title, image: image, tag: 0)
       let navController = UINavigationController(rootViewController: viewCtrl)
       navController.navigationBar.prefersLargeTitles = false
       navController.tabBarItem = item
       viewCtrl.navigationItem.title = title
           
       return navController
    }
    
    func setupVC() {
        let feedViewCtrl = createNavController(viewCtrl: FeedViewController(), title: NSLocalizedString("Лента", comment: ""), image: UIImage(systemName: "photo.on.rectangle.fill")!)
        let profileViewCtrl = createNavController(viewCtrl: LoginViewController(), title: NSLocalizedString("Профиль", comment: ""), image: UIImage(systemName: "brain.head.profile")!)
        let animationViewCtrl = createNavController(viewCtrl: AnimationViewController(), title: NSLocalizedString("Анимация", comment: ""), image: UIImage(systemName: "arrow.down")!)
        viewControllers = [feedViewCtrl, profileViewCtrl, animationViewCtrl]
    }
}
