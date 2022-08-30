//
//  CodeView.swift
//  Challenge3
//
//  Created by Edgar Arlindo on 30/08/22.
//

import Foundation

protocol CodeView {
    func buildViewHierarchy()
    func setupConstrains()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstrains()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() {}
}
