//
//  ViewModel.swift
//  proof-of-work
//
//  Created by 신동규 on 2022/03/27.
//

import Foundation
import Combine
import RxSwift

final class ViewModel {
    
    static let `default` = ViewModel()
    
    var cancellables: Set<AnyCancellable> = []
    let disposeBag = DisposeBag()
    
    @Published var prevHash: String = ""
    @Published var data: String = ""
    @Published var difficulty: Int = 0
    @Published var nonce: Int = 0
    @Published var currentHash: String = ""
    @Published var blocks: [Block] = []
    @Published var canAddBlock = false
    
    private init() {
        bind()
    }
    
    public func createNewBlock() {
        let block: Block = .init(hash: currentHash, data: data)
        self.blocks.append(block)
        data = ""
        nonce = 0 
    }
    
    private func bind() {
        
        $prevHash.combineLatest($data, $nonce).sink { [weak self] prevHash, data, nonce in
            if data.isEmpty {
                self?.currentHash = ""
                return
            }
            self?.currentHash = Hash.default.sha256(original: "\(prevHash)\(data)\(nonce)")
        }.store(in: &cancellables)
        
        $blocks.sink { [weak self] blocks in
            self?.prevHash = blocks.last?.hash ?? ""
        }.store(in: &cancellables)
        
        $currentHash.combineLatest($difficulty, $data) .sink { [weak self] currentHash, difficulty, data in
            if data.isEmpty == true {
                self?.canAddBlock = false
                return
            }
            var canAddBlock = true
            String(currentHash.prefix(difficulty)).forEach({
                if $0 != "0" { canAddBlock = false }
            })
            self?.canAddBlock = canAddBlock
        }.store(in: &cancellables)
    }
    
}
