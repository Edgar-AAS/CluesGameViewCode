//
//  QuizScreen.swift
//  Challenge3
//
//  Created by Edgar Arlindo on 30/08/22.
//

import UIKit

protocol CluesScreenDelegate: AnyObject {
    func didSubmitTapped()
}

class CluesScreen: UIView {
    private weak var delegate: CluesScreenDelegate?
    
    convenience init(delegate: CluesScreenDelegate?) {
        self.init(frame: .zero)
        self.delegate = delegate
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var clueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = ""
        label.sizeToFit()
        return label
    }()
    
    lazy var labelScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.text = "Score: 0"
        return label
    }()
    
    lazy var labelsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var letterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    lazy var buttonsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var buttonsSubView: UIView = {
        let subview = UIView()
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.layer.cornerRadius = 12
        subview.layer.borderWidth = 2
        subview.layer.borderColor = UIColor.darkGray.cgColor
        return subview
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SUBMIT", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        //delegate button
        button.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.darkGray.cgColor
        return button
    }()
    
    @objc private func didTapSubmitButton() {
        delegate?.didSubmitTapped()
    }
}

extension CluesScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(clueLabel)
        addSubview(labelScore)
        addSubview(labelsView)
        addSubview(letterLabel)
        addSubview(buttonsView)
        buttonsView.addSubview(buttonsSubView)
        buttonsView.addSubview(submitButton)
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
        labelScore.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
        labelScore.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        
        clueLabel.topAnchor.constraint(equalTo: labelScore.bottomAnchor),
        clueLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20),
        clueLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -20),
        
        labelsView.topAnchor.constraint(equalTo: clueLabel.bottomAnchor),
        labelsView.heightAnchor.constraint(equalToConstant: 200),
        labelsView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
        labelsView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        
        letterLabel.topAnchor.constraint(equalTo: labelsView.topAnchor, constant: 40),
        letterLabel.heightAnchor.constraint(equalToConstant: 100),
        letterLabel.leadingAnchor.constraint(equalTo: labelsView.leadingAnchor),
        letterLabel.trailingAnchor.constraint(equalTo: labelsView.trailingAnchor),
        
        buttonsView.topAnchor.constraint(equalTo: labelsView.bottomAnchor, constant: 20),
        buttonsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
        buttonsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
        buttonsView.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor),
        
        buttonsSubView.topAnchor.constraint(equalTo: buttonsView.topAnchor, constant: 20),
        buttonsSubView.heightAnchor.constraint(equalToConstant: 230),
        buttonsSubView.widthAnchor.constraint(equalToConstant: 650),
        buttonsSubView.centerXAnchor.constraint(equalTo: buttonsView.centerXAnchor),
        
        submitButton.topAnchor.constraint(equalTo: buttonsSubView.bottomAnchor, constant: 10),
        submitButton.centerXAnchor.constraint(equalTo: buttonsSubView.centerXAnchor),
        submitButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .lightGray
    }
}
