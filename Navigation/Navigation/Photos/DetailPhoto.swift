import UIKit

class DetailPhoto: UIView {
    
  //  var selectedImage: String?
    
    lazy var photo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
    //    if let image = selectedImage {
    //        imageView.image = UIImage(named: image)
     //   }
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setImageToView(image: String) {
        photo.image = UIImage(named: image)
    }
    
    private lazy var xButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.alpha = 1
        button.clipsToBounds = true
        button.setImage(.init(systemName: "xmark.circle"), for: .normal)
        button.addTarget(self, action: #selector(xPressed), for: .touchUpInside)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.backgroundColor = .white
        self.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {
        self.addSubview(photo)
        self.addSubview(xButton)
        NSLayoutConstraint.activate([
            self.xButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            self.xButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.xButton.heightAnchor.constraint(equalToConstant: 30),
            self.xButton.widthAnchor.constraint(equalToConstant: 30),
            self.photo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.photo.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.photo.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    @objc private func xPressed() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.alpha = 0
            self.transform = .identity
        }
    }
}
