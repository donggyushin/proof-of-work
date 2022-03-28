//
//  ViewController.swift
//  proof-of-work
//
//  Created by 신동규 on 2022/03/27.
//

import UIKit

class ViewController: UIViewController {
    
    private let blockInputView = InputView()
    private let viewModel = ViewModel.default
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = .systemBackground
        view.register(BlockCell.self, forCellReuseIdentifier: BlockCell.identifier)
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        view.backgroundColor = .systemBackground
        
        view.addSubview(blockInputView)
        view.addSubview(tableView)
        
        blockInputView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blockInputView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            blockInputView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            blockInputView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: blockInputView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: blockInputView.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: blockInputView.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bind() {
        viewModel.$blocks.sink { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &viewModel.cancellables)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.blocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BlockCell.identifier) as? BlockCell ?? BlockCell()
        cell.item = viewModel.blocks[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
}
