//
//  FrequentWordViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/01.
//

import UIKit

import Moya

final class FrequentWordViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let frequentWordView = FrequentWordView()
    private let dummyData: [FrequentWord] = [FrequentWord(word: "오늘", count: 7),
                                             FrequentWord(word: "점심", count: 4),
                                             FrequentWord(word: "학교", count: 3),
                                             FrequentWord(word: "엄마", count: 2),
                                             FrequentWord(word: "친구", count: 1),]
    
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
    
    override func customNavigationBar() {
        navigationController?.navigationBar.tintColor = .cooingBrown2
        let backButton: UIBarButtonItem = UIBarButtonItem()
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationItem.title = "레포트"
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.button1(),
            NSAttributedString.Key.foregroundColor: UIColor.cooingBrown2
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
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
        cell.configureCell(index: indexPath.row, wordData: dummyData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.adjusted
    }
}

extension FrequentWordViewController {
    private func getUsingWordData() {
        
    }
}
