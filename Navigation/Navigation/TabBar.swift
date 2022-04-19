//
//  TabBar.swift
//  Navigation
//
//  Created by Igor Situn on 19.04.2022.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVC()
        super.viewDidLoad()
    }
    
   fileprivate func createNavController(viewCtrl: UIViewController,
                                                        title: String,
                                                        image: UIImage) -> UIViewController {
       let item = UITabBarItem(title: title, image: image, tag: 0)
       item.titlePositionAdjustment = .init(horizontal: 0, vertical: 0)
       let navController = UINavigationController(rootViewController: viewCtrl)
       navController.navigationBar.prefersLargeTitles = true
       navController.tabBarItem = item
       viewCtrl.navigationItem.title = title
           
       return navController
    }
    
    func setupVC() {
        let feedViewCtrl = createNavController(viewCtrl: FeedViewController(), title: NSLocalizedString("Лента", comment: ""), image: UIImage(systemName: "photo.on.rectangle.fill")!)
        let profileViewCtrl = createNavController(viewCtrl: ProfileViewController(), title: NSLocalizedString("Профиль", comment: ""), image: UIImage(systemName: "brain.head.profile")!)
        viewControllers = [feedViewCtrl, profileViewCtrl]
    }
}
