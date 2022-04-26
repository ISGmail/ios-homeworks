//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Igor Situn on 24.04.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    private enum Constants {
            static let itemCount: CGFloat = 3
        }
        
    let detailPhoto = DetailPhoto()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        return layout
    }()
        
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCollectionCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var photosCollection: [PhotosCollection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.massivOfPhotos()
        self.setupView()
        self.title = "Фотогалерея"
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .white
    }
        
    private func setupView() {
        self.view.addSubview(self.collectionView)
        self.detailPhoto.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(detailPhoto)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailPhoto.topAnchor.constraint(equalTo: view.topAnchor),
            detailPhoto.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailPhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
        
        private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
            let neededWidth = width - 4 * spacing
            let itemWidth = floor(neededWidth / Constants.itemCount)
            return CGSize(width: itemWidth, height: itemWidth)
        }
        
        private func massivOfPhotos() {
            for n in 11...32 {
                photosCollection.append(PhotosCollection(image: String(n)))
            }
        }
    }

    extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.photosCollection.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCollectionCell", for: indexPath)
                cell.backgroundColor = .black
                return cell
            }
            cell.backgroundColor = .systemGray6
            let photos = photosCollection[indexPath.row]
            cell.photos.image = UIImage(named: photos.image)
            cell.photos.contentMode = .scaleAspectFill
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
                let imageToView = self.photosCollection[indexPath.item].image
                self.detailPhoto.setImageToView(image: imageToView)
                self.detailPhoto.transform = .identity
                self.detailPhoto.alpha = 1
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
            let spacing = ( collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
            return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
        }
    }
