//
//  FrequentWordViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/01.
//

import UIKit

final class FrequentWordViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let frequentWordView = FrequentWordView()
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setTableView()
    }
    
    // MARK: - Functions

    override func hieararchy() {
        self.view.addSubview(frequentWordView)
    }

    override func setLayout() {
        frequentWordView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setButtonEvent() {
        //override Point
    }
    
    private func setTableView() {
        frequentWordView.rankingTableView.register(FrequentTableViewCell.self, forCellReuseIdentifier: FrequentTableViewCell.identifier)
        
        frequentWordView.rankingTableView.dataSource = self
        frequentWordView.rankingTableView.delegate = self
    }
}

extension FrequentWordViewController: UITableViewDelegate {}

extension FrequentWordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FrequentTableViewCell.identifier, for: indexPath) as? FrequentTableViewCell ?? FrequentTableViewCell()
        cell.configureCell(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.adjusted
    }
}
