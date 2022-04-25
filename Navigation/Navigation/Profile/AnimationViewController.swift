//
//  ViewController.swift
//  Navigation
//
//  Created by Igor Situn on 25.04.2022.
//

import UIKit

class AnimationViewController: UIViewController {


       private var imageView: UIImageView = {
           let imageView = UIImageView(image: UIImage(named: "Cat"))
           imageView.backgroundColor = .red
           imageView.contentMode = .scaleAspectFill
           imageView.layer.cornerRadius = 75
           imageView.clipsToBounds = true
           imageView.layer.borderWidth = 3
           imageView.layer.borderColor = UIColor.white.cgColor
           imageView.isUserInteractionEnabled = true
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()

       private lazy var xMarkButton: UIButton = {
           let button = UIButton()
           button.layer.cornerRadius = 20
           button.alpha = 0
           button.clipsToBounds = true
           button.setImage(.init(systemName: "xmark.circle"), for: .normal)
           button.addTarget(self, action: #selector(self.didTapSetStatusButton), for: .touchUpInside)
           button.backgroundColor = .white
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()

       private let screenWidth = UIScreen.main.bounds.width
       private let screenHeight = UIScreen.main.bounds.height

       private let tapGestureRecognizer = UITapGestureRecognizer()
       private var viewCenterXConstraint: NSLayoutConstraint?
       private var viewCenterYConstraint: NSLayoutConstraint?
       private var viewHeightConstraint: NSLayoutConstraint?
       private var viewWidthConstraint: NSLayoutConstraint?

       private var isExpanded = false

       override func viewDidLoad() {
           super.viewDidLoad()
           self.navigationController?.navigationBar.prefersLargeTitles = false
           view.backgroundColor = .white
           self.setupView()
           self.setupGesture()
       }

       private func setupView() {
           view.addSubview(imageView)
           view.addSubview(xMarkButton)

           self.viewCenterXConstraint = self.imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -1 * (screenWidth * 0.5 - 100))
           self.viewCenterYConstraint = self.imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -1 * (screenHeight * 0.5 - 183))
           self.viewHeightConstraint = self.imageView.heightAnchor.constraint(equalToConstant: 150)
           self.viewWidthConstraint = self.imageView.widthAnchor.constraint(equalToConstant: 150)

           let widthAnchorImageView = self.imageView.widthAnchor.constraint(equalToConstant: 150)
           let heightAnchorImageView = self.imageView.heightAnchor.constraint(equalToConstant: 150)
           let topAnchorImageView = self.imageView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 16)
           let leadingAnchorImageView = self.imageView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor)
           
           let xMarkButtonTopConstraint = xMarkButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
           let xMarkButtonTrailConstraint = xMarkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
           let xMarkButtonHeightConstraint = xMarkButton.heightAnchor.constraint(equalToConstant: 40)
           let xMarkButtonWidthConstraint = xMarkButton.widthAnchor.constraint(equalToConstant: 40)

           NSLayoutConstraint.activate([
               self.viewCenterXConstraint, self.viewCenterYConstraint,
               self.viewHeightConstraint, self.viewWidthConstraint,
               widthAnchorImageView, heightAnchorImageView, topAnchorImageView, leadingAnchorImageView,
               xMarkButtonTopConstraint, xMarkButtonTrailConstraint, xMarkButtonWidthConstraint, xMarkButtonHeightConstraint

           ].compactMap({ $0 }))
       }

       private func setupGesture() {
           self.tapGestureRecognizer.addTarget(self, action: #selector(self.handleTapGesture(_ :)))
           self.imageView.addGestureRecognizer(self.tapGestureRecognizer)
       }

       @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
           guard self.tapGestureRecognizer === gestureRecognizer else { return }
           self.isExpanded.toggle()
           self.viewCenterXConstraint?.constant = self.isExpanded ? 0 : -1 * (screenWidth * 0.5 - 100)
           self.viewCenterYConstraint?.constant = self.isExpanded ? 0 : -1 * (screenHeight * 0.5 - 183)
           self.viewHeightConstraint?.constant = self.isExpanded ? screenWidth : 150
           self.viewWidthConstraint?.constant = self.isExpanded ? screenWidth : 150

           UIView.animate(withDuration: 0.5) {
               self.imageView.layer.cornerRadius = self.isExpanded ? 0 : 75
               self.view.layoutIfNeeded()
           } completion: { _ in
           }

           if self.isExpanded {
               self.xMarkButton.isHidden = false
           }

           UIView.animate(withDuration: 0.3, delay: 0.5) {
               self.xMarkButton.alpha = self.isExpanded ? 1 : 0
           } completion: { _ in
               self.xMarkButton.isHidden = !self.isExpanded
           }
       }

       @objc private func didTapSetStatusButton() {
           self.viewCenterXConstraint?.constant = -1 * (screenWidth * 0.5 - 100)
           self.viewCenterYConstraint?.constant = -1 * (screenHeight * 0.5 - 183)
           self.viewHeightConstraint?.constant = 150
           self.viewWidthConstraint?.constant = 150

           UIView.animate(withDuration: 0.5) {
               self.imageView.layer.cornerRadius = 75
               self.view.layoutIfNeeded()
           } completion: { _ in
           }

           UIView.animate(withDuration: 0.3, delay: 0.5) {
               self.xMarkButton.alpha = 0
           } completion: { _ in
               self.xMarkButton.isHidden = false
               self.isExpanded = false
           }
       }
   }
