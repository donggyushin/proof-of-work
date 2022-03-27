//
//  InputView.swift
//  proof-of-work
//
//  Created by 신동규 on 2022/03/27.
//

import UIKit
import Combine
import RxCocoa

class InputView: UIView {
    
    
    let viewModel: ViewModel = ViewModel.default
    
    private let prevHashLabel = UILabel()
    
    private let dataLabel = UILabel()
    
    private let dataTextField = UITextField()
    
    private lazy var dataContainer: UIStackView = {
        let view = UIStackView(arrangedSubviews: [dataLabel, dataTextField])
        return view
    }()
    
    private let difficultyLabel = UILabel()
    
    private lazy var difficultyUpButton: UIButton = {
        let view = UIButton(configuration: UIButton.Configuration.tinted(), primaryAction: UIAction(handler: { _ in
            self.viewModel.difficulty += 1
        }))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.setTitle("+", for: .normal)
        return view
    }()
    
    private lazy var difficultyDownButton: UIButton = {
        let view = UIButton(configuration: UIButton.Configuration.tinted(), primaryAction: UIAction(handler: { _ in
            self.viewModel.difficulty -= 1
        }))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.setTitle("-", for: .normal)
        return view
    }()
    
    private lazy var difficultyContainer: UIStackView = {
        let view = UIStackView(arrangedSubviews: [difficultyLabel, difficultyUpButton, difficultyDownButton])
        view.axis = .horizontal
        return view
    }()
    
    private let nonceLabel = UILabel()
    
    private lazy var nonceUpButton: UIButton = {
        let view = UIButton(configuration: UIButton.Configuration.tinted(), primaryAction: UIAction(handler: { _ in
            self.viewModel.nonce += 1
        }))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.setTitle("+", for: .normal)
        return view
    }()
    
    private lazy var nonceDownButton: UIButton = {
        let view = UIButton(configuration: UIButton.Configuration.tinted(), primaryAction: UIAction(handler: { _ in
            if self.viewModel.nonce > 0 {
                self.viewModel.nonce -= 1
            }
        }))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.setTitle("-", for: .normal)
        return view
    }()
    
    private lazy var nonceContainer: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nonceLabel, nonceUpButton, nonceDownButton])
        view.axis = .horizontal
        return view
    }()
    
    private let currentHashLabel = UILabel()
    
    private lazy var findButton: UIButton = {
        let view = UIButton(configuration: UIButton.Configuration.tinted(), primaryAction: UIAction(handler: { _ in
            self.viewModel.findCorrectNonce()
        }))
        view.setTitle("Auto", for: .normal)
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton(configuration: UIButton.Configuration.tinted(), primaryAction: UIAction(handler: { _ in
            self.viewModel.createNewBlock()
        }))
        view.setTitle("Add", for: .normal)
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [prevHashLabel, dataContainer, difficultyContainer, nonceContainer, currentHashLabel, findButton, addButton])
        view.axis = .vertical
        view.spacing = 10 
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        prevHashLabel.numberOfLines = 0
        currentHashLabel.numberOfLines = 0 
        dataLabel.text = "data: "
        addSubview(verticalStackView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.leftAnchor.constraint(equalTo: leftAnchor),
            verticalStackView.rightAnchor.constraint(equalTo: rightAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func bind() {
        
        dataTextField.rx.text.subscribe(onNext: { text in
            self.viewModel.data = text ?? ""
        }).disposed(by: viewModel.disposeBag)
        
        viewModel.$data.sink { value in
            self.dataTextField.text = value
        }.store(in: &viewModel.cancellables)
        
        viewModel.$nonce.sink { value in
            self.nonceLabel.text = "nonce: \(value)"
        }.store(in: &viewModel.cancellables)
        
        viewModel.$prevHash.sink { value in
            self.prevHashLabel.text = "prev hash: \(value.isEmpty ? "none" : value)"
        }.store(in: &viewModel.cancellables)
        
        viewModel.$difficulty.sink { value in
            self.difficultyLabel.text = "difficuly: \(value)"
        }.store(in: &viewModel.cancellables)
        
        viewModel.$currentHash.sink { value in
            self.currentHashLabel.text = "current hash: \(value)"
        }.store(in: &viewModel.cancellables)
        
        viewModel.$canAddBlock.sink { value in
            self.addButton.isEnabled = value
        }.store(in: &viewModel.cancellables)
    }
}
