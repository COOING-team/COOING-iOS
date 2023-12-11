//
//  SecretNoteViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import Moya

final class SecretNoteViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let reportProvider = MoyaProvider<ReportRouter>(plugins: [MoyaLoggingPlugin()])
    private var secretNoteData: [SecretNoteList] = []
    
    // MARK: - UI Components
    
    private let secretNoteView = SecretNoteView()
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setTableView()
        setNetworkFunctions()
    }
    
    // MARK: - Functions

    override func hieararchy() {
        self.view.addSubview(secretNoteView)
    }

    override func setLayout() {
        secretNoteView.snp.makeConstraints {
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
        secretNoteView.weeklyReportTableView.register(SecretNoteTableViewCell.self, forCellReuseIdentifier: SecretNoteTableViewCell.identifier)
        
        secretNoteView.weeklyReportTableView.dataSource = self
        secretNoteView.weeklyReportTableView.delegate = self
    }
    
    private func setNetworkFunctions() {
        getSecretNoteListData()
    }
    
    func setName(name: String) {
        secretNoteView.wordTitleLabel.text = "\(name)의 시크릿 노트"
        secretNoteView.wordSubTitleLabel.text = "\(name)의 언어를 더 자세히 분석해요."
    }
}

extension SecretNoteViewController: UITableViewDelegate {}

extension SecretNoteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secretNoteData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SecretNoteTableViewCell.identifier, for: indexPath) as? SecretNoteTableViewCell ?? SecretNoteTableViewCell()
        cell.selectionStyle = .none
        cell.configureCell(data: secretNoteData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.adjusted
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch secretNoteData[indexPath.row].noteStatus {
        case "READABLE":
            let levelReportViewController = LevelReportViewController()
            levelReportViewController.setMonthWeek(month: secretNoteData[indexPath.row].month,
                                                   week: secretNoteData[indexPath.row].week)
            navigationController?.pushViewController(levelReportViewController, animated: true)
        case "NOT_CREATABLE":
            showAlert(title: "해당 주차의 시크릿 노트가 \n아직 생성되지 않았어요",
                      text: "시크릿 노트가 생성될 때 까지 조금만 기다려주세요!", style: .default)
        default:
            return
        }
    }
}

// MARK: - Network

extension SecretNoteViewController {
    private func getSecretNoteListData() {
        self.reportProvider.request(.secretNoteList(month: 12)) { response in
            switch response {
            case .success(let moyaResponse):
                do {
                    let responseData = try moyaResponse.map(GenericResponse<SecretNoteListDTO>.self)
                    self.secretNoteData = responseData.result.secretNoteLists
                    self.secretNoteView.weeklyReportTableView.reloadData()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
