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
