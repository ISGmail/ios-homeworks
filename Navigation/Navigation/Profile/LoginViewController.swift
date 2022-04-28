//
//  LoginViewController.swift
//  Navigation
//
//  Created by Igor Situn on 22.04.2022.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private var defaultEmail: String = "isgmail@mail.ru"
    private var defaultPassword: String = "trustno1"
    private var minCountPass: Int = 6

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
        }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray5
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray5
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "E-mail или номер телефона"
        textField.layer.borderWidth = 0.5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray5
        textField.isSecureTextEntry = true
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "Пароль"
        textField.layer.borderWidth = 0.5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var labelAlert: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.alpha = 0
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.black.cgColor
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureSubviews()
        self.setupConstraints()
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        addTapGestureToHideKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.loginButton)
        self.contentView.addSubview(self.logoImageView)
        self.contentView.addSubview(self.loginPasswordStackView)
        self.loginPasswordStackView.addArrangedSubview(self.loginTextField)
        self.loginPasswordStackView.addArrangedSubview(self.passwordTextField)
        self.contentView.addSubview(labelAlert)
    }
    
    private func setupConstraints() {
        
        let topConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leftConstraint = self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        let rightConstraint = self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        let bottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        let contentViewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let contentViewBottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        let contentViewCenterXConstraint = self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let contentViewWidthConstraint = self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let contentViewHeightConstraint = self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        
        let topLogoImageViewConstraint = self.logoImageView.topAnchor.constraint(lessThanOrEqualTo: self.contentView.topAnchor, constant: 120)
        topLogoImageViewConstraint.priority = UILayoutPriority(999)
        let centerXLogoImageViewConstraint = self.logoImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        let widthLogoImageViewConstraint = self.logoImageView.widthAnchor.constraint(equalToConstant: 100)
        let heightLogoImageViewConstraint = self.logoImageView.heightAnchor.constraint(equalToConstant: 100)
        let bottomLogoImageViewConstraint = self.logoImageView.bottomAnchor.constraint(greaterThanOrEqualTo: self.loginPasswordStackView.topAnchor, constant: -70)

        let centerYLoginPasswordStackViewConstraint = self.loginPasswordStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        let leftLoginPasswordStackViewConstraint = self.loginPasswordStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let rightLoginPasswordStackViewConstraint = self.loginPasswordStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let heightLoginPasswordStackViewConstraint = self.loginPasswordStackView.heightAnchor.constraint(equalToConstant: 100)
        
        let topLogInButtonConstraint = self.loginButton.topAnchor.constraint(equalTo: self.loginPasswordStackView.bottomAnchor, constant: 16)
        let leadingLogInButtonConstraint = self.loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let trailingLogInButtonConstraint = self.loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let heightLogInButtonConstraint = self.loginButton.heightAnchor.constraint(equalToConstant: 50)

        let labelAlertTopAnchor = labelAlert.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 20)
        let labelAlertLeadingAnchor = labelAlert.leadingAnchor.constraint(equalTo: self.loginPasswordStackView.leadingAnchor)
        let labelAlertTrailingAnchor = labelAlert.trailingAnchor.constraint(equalTo: self.loginPasswordStackView.trailingAnchor)
        let labelAlertHeight = labelAlert.heightAnchor.constraint(equalToConstant: 80)
        
        NSLayoutConstraint.activate([
            topConstraint,
            leftConstraint,
            rightConstraint,
            bottomConstraint,
            
            contentViewTopConstraint,
            contentViewBottomConstraint,
            contentViewWidthConstraint,
            contentViewHeightConstraint,
            contentViewCenterXConstraint,
            topLogoImageViewConstraint,
            
            centerXLogoImageViewConstraint,
            widthLogoImageViewConstraint,
            heightLogoImageViewConstraint,
            bottomLogoImageViewConstraint,
            
            centerYLoginPasswordStackViewConstraint,
            leftLoginPasswordStackViewConstraint,
            rightLoginPasswordStackViewConstraint,
            heightLoginPasswordStackViewConstraint,
            
            topLogInButtonConstraint,
            leadingLogInButtonConstraint,
            trailingLogInButtonConstraint,
            heightLogInButtonConstraint,
            
            labelAlertTopAnchor,
            labelAlertLeadingAnchor,
            labelAlertTrailingAnchor,
            labelAlertHeight
        ])
    }
    
    @objc private func buttonClicked() {
        
        var needShowAlert: Bool = false
        let profileViewController = ProfileViewController()
        
        //Отобразить нижний лейбл вью если с количеством символов беда
        if self.passwordTextField.text?.count ?? 0 < 6 {
            labelAlert.alpha = 1
            labelAlert.text = "Ошибка. Минимальное количество символов пароля: " + String(minCountPass)
        } else {
            labelAlert.alpha = 0
        }
        
        if self.loginTextField.text == "" {
            self.loginTextField.layer.borderColor = UIColor.red.cgColor
            self.loginTextField.layer.borderWidth = 5
        }
        else {
            self.loginTextField.layer.borderColor = UIColor.lightGray.cgColor
            self.loginTextField.layer.borderWidth = 0.5
        }
        if self.passwordTextField.text == "" {
            self.passwordTextField.layer.borderColor = UIColor.red.cgColor
            self.passwordTextField.layer.borderWidth = 5
        }
        else {
            self.passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
            self.passwordTextField.layer.borderWidth = 0.5
        }
        if (self.loginTextField.text == defaultEmail) && (self.passwordTextField.text == defaultPassword) {
          navigationController?.pushViewController(profileViewController, animated: true)
          navigationController?.navigationBar.isHidden = true
        }
        else {
            if self.loginTextField.text != defaultEmail {
                loginTextField.shake()
                needShowAlert = true
            }
            if self.passwordTextField.text != defaultPassword {
                passwordTextField.shake()
                needShowAlert = true
            }
        }
        if needShowAlert && self.passwordTextField.text != "" && self.loginTextField.text != "" {
            let alert = UIAlertController(title: "Введены неверные учетные данные", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    @objc func adjustForKeyboard (notification: Notification){
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let loginButtonPointY = self.loginButton.frame.origin.y + 50
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < loginButtonPointY ? loginButtonPointY - keyboardOriginY + 16 : 0
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }

    @objc private func kbdHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

}

extension UIView {
    func shake(count: Float = 5, for duration: TimeInterval = 0.5, withTranslation translation: Float = 3) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}
