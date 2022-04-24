//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Igor Situn on 24.04.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner
        ]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
    lazy var photos: UIImageView = {
        let photoGalleryImages = UIImageView()
        photoGalleryImages.clipsToBounds = true
        photoGalleryImages.translatesAutoresizingMaskIntoConstraints = false
        return photoGalleryImages
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(photos)
        NSLayoutConstraint.activate([
            photos.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            photos.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            photos.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            photos.widthAnchor.constraint(equalTo: self.contentView.widthAnchor)
        ])
    }
}
