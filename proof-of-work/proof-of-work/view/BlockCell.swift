//
//  BlockCell.swift
//  proof-of-work
//
//  Created by Donggyu Shin on 2022/03/28.
//

import UIKit

class BlockCell: UITableViewCell {
    
    static let identifier = "BlockCellIdentifier"
    
    var item: Block? {
        didSet {
            guard let item = item else {
                return
            }
            configUI(with: item)
        }
    }
    
    private let hashLabel = UILabel()
    private let dataLabel = UILabel()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [hashLabel, dataLabel])
        hashLabel.numberOfLines = 0
        dataLabel.numberOfLines = 0
        view.spacing = 10
        view.axis = .vertical
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        contentView.addSubview(verticalStackView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    private func configUI(with item: Block) {
        hashLabel.text = "hash: \(item.hash)"
        dataLabel.text = "data: \(item.data)"
    }
}
