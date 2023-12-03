//
//  SecretNoteViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

final class SecretNoteViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let secretNoteView = SecretNoteView()
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setTableView()
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
}

extension SecretNoteViewController: UITableViewDelegate {}

extension SecretNoteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SecretNoteTableViewCell.identifier, for: indexPath) as? SecretNoteTableViewCell ?? SecretNoteTableViewCell()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.adjusted
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let levelReportViewController = LevelReportViewController()
        navigationController?.pushViewController(levelReportViewController, animated: true)
    }
}
