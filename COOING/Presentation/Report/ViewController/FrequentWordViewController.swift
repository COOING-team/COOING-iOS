//
//  FrequentWordViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/01.
//

import UIKit

import Moya

final class FrequentWordViewController: BaseViewController {
    
    // MARK: - Properites
    
    private let reportProvider = MoyaProvider<ReportRouter>(plugins: [MoyaLoggingPlugin()])
    
    // MARK: - UI Components
    
    private let frequentWordView = FrequentWordView()
    private var responseData: FrequentWordDTO?
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFrequentWordData()
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
    
    func setName(name: String) {
        frequentWordView.wordSubTitleLabel.text = "\(name)가 지난 한 주 동안 가장 많이 사용한 단어예요."
    }
}

extension FrequentWordViewController: UITableViewDelegate {}

extension FrequentWordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FrequentTableViewCell.identifier, for: indexPath) as? FrequentTableViewCell ?? FrequentTableViewCell()
        switch indexPath.row {
        case 0:
            if responseData?.frequentWords.firstWord.count ?? -1 <= 0 {
                cell.isHidden = true
            } else {
                cell.configureCell(index: indexPath.row,
                                   wordData: responseData?.frequentWords.firstWord ?? Word(word: "", count: 0))
            }
        case 1:
               if responseData?.frequentWords.secondWord.count ?? -1 <= 0 {
                   cell.isHidden = true
               } else {
                   cell.configureCell(index: indexPath.row,
                                      wordData: responseData?.frequentWords.secondWord ?? Word(word: "", count: 0))
               }
        case 2:
            if responseData?.frequentWords.thirdWord.count ?? -1 <= 0 {
                cell.isHidden = true
            } else {
                cell.configureCell(index: indexPath.row,
                                   wordData: responseData?.frequentWords.thirdWord ?? Word(word: "", count: 0))
            }
        case 3:
            if responseData?.frequentWords.fourthWord.count ?? -1 <= 0 {
                cell.isHidden = true
            } else {
                cell.configureCell(index: indexPath.row,
                                   wordData: responseData?.frequentWords.fourthWord ?? Word(word: "", count: 0))
            }
        case 4:
            if responseData?.frequentWords.fifthWord.count ?? -1 <= 0 {
                cell.isHidden = true
            } else {
                cell.configureCell(index: indexPath.row,
                                   wordData: responseData?.frequentWords.fifthWord ?? Word(word: "", count: 0))
            }
        default:
            cell.configureCell(index: indexPath.row,
                               wordData: responseData?.frequentWords.firstWord ?? Word(word: "", count: 0))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.adjusted
    }
}

extension FrequentWordViewController {
    private func getFrequentWordData() {
        self.reportProvider.request(.frequent) { response in
            switch response {
            case .success(let moyaResponse):
                do {
                    let responseData = try moyaResponse.map(GenericResponse<FrequentWordDTO>.self)
                    self.responseData = responseData.result
                    self.frequentWordView.rankingTableView.reloadData()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
