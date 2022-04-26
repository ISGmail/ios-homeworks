//
//  Setupable.swift
//  Navigation
//
//  Created by Igor Situn on 23.04.2022.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}

protocol TapLikedDelegate: AnyObject {
    func tapLikedLabel()
}

protocol ChangeViewsDelegate: AnyObject {
    func viewsChanged(at indexPath: IndexPath)
}
