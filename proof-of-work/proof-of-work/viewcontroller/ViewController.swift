//
//  ViewController.swift
//  proof-of-work
//
//  Created by 신동규 on 2022/03/27.
//

import UIKit

class ViewController: UIViewController {
    
    private let blockInputView = InputView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(blockInputView)
        
        blockInputView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blockInputView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            blockInputView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            blockInputView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
}
