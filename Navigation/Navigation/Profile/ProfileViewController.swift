//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Igor Situn on 19.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var headerHeight: CGFloat = 220
    private var addPosts: [Post] = posts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileHeaderViewSetup()
        view.addSubview(tableView)
        setConstraintsToView()
    }

    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private lazy var tableView: UITableView = {
           let tableView = UITableView(frame: .zero, style: .grouped)
           tableView.translatesAutoresizingMaskIntoConstraints = false
           tableView.rowHeight = UITableView.automaticDimension
           tableView.dataSource = self
           tableView.delegate = self
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
           tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
           tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
           tableView.backgroundColor = .clear
           tableView.backgroundColor = .systemGray6
           tableView.layer.borderColor = UIColor.lightGray.cgColor
           tableView.layer.borderWidth = 0.5
           return tableView
       }()
    
    private func profileHeaderViewSetup() {
            self.view.backgroundColor = .white
            self.view.addSubview(self.profileHeaderView)
            
            let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
            let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
            let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
            let heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
            
            NSLayoutConstraint.activate([
                topConstraint,
                leadingConstraint,
                trailingConstraint,
                heightConstraint
            ].compactMap({$0}))
        }
    
    private func setConstraintsToView() {
    
        let tableViewTopConstraint = self.tableView.topAnchor.constraint(equalTo: self.profileHeaderView.bottomAnchor)
        let tableViewBottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
               let tableViewLeadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
               let tableViewTrailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
               
               NSLayoutConstraint.activate([
                   tableViewTopConstraint,
                   tableViewBottomConstraint,
                   tableViewLeadingConstraint,
                   tableViewTrailingConstraint
               ])
    }
        
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addPosts.count + 1
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            let article = self.addPosts[indexPath.row - 1]
            let viewModel = PostTableViewCell.ViewModel(author: article.author,
                                                        image: article.image,
                                                        description: article.description,
                                                        likes: article.likes,
                                                        views: article.views)
            cell.setup(with: viewModel)
            return cell
        }
    }
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        self.navigationController?.pushViewController(PhotosViewController(), animated: true)
        } else { return }
    }
    
}
