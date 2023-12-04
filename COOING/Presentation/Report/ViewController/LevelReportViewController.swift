//
//  LevelReportViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import Moya

final class LevelReportViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let reportProvider = MoyaProvider<ReportRouter>(plugins: [MoyaLoggingPlugin()])
    private let headerTitle: [String] = ["구문 구조", "문장 성분의 의미", "문법 형태소"]
    let pickerData = ["1단계", "2단계", "3단계"]
    private var sectionLevelData: [SecretNoteLevel] = [SecretNoteLevel.setFirstLevelSection(), SecretNoteLevel.setSecondLevelSection(), SecretNoteLevel.setThirdLevelSection()]
    
    private var firstSectionLevelData = SecretNoteLevel.setFirstLevelSection()
    private var secondSectionLevelData = SecretNoteLevel.setSecondLevelSection()
    private var thirdSectionLevelData = SecretNoteLevel.setThirdLevelSection()
    private var stateData: [[Bool]]?
    private var currentLevel: Int = 0
    
    // MARK: - UI Components
    
    private let levelReportView = LevelReportView()
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setTableView()
        setDelegate()
        getSecretNoteData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSecretNoteData()
    }
    
    // MARK: - Functions

    override func hieararchy() {
        self.view.addSubview(levelReportView)
    }

    override func setLayout() {
        levelReportView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setButtonEvent() {
        levelReportView.backStackViewHandler = { [weak self] in
            guard let self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        levelReportView.levelStackViewHandler = { [weak self] in
            guard let self else { return }
            self.levelReportView.levelPickerView.isHidden = false
        }
    }
    
    override func customNavigationBar() {
        navigationItem.hidesBackButton = true
        
        navigationItem.title = "레포트"
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.button1(),
            NSAttributedString.Key.foregroundColor: UIColor.cooingBrown2
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }

    private func setTableView() {
        levelReportView.levelReportTableView.register(LevelTableViewCell.self,
                                                      forCellReuseIdentifier: LevelTableViewCell.identifier)

        levelReportView.levelReportTableView.register(LevelTableViewHeaderView.self,
                                                      forHeaderFooterViewReuseIdentifier: LevelTableViewHeaderView.identifier)
        levelReportView.levelReportTableView.register(LevelTableSectionFooterView.self,
                                                      forHeaderFooterViewReuseIdentifier: LevelTableSectionFooterView.identifier)
    }
    
    private func setDelegate() {
        levelReportView.levelReportTableView.dataSource = self
        levelReportView.levelReportTableView.delegate = self
        
        levelReportView.levelPickerView.delegate = self
        levelReportView.levelPickerView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, DataSource

extension LevelReportViewController: UITableViewDelegate {}

extension LevelReportViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: LevelTableViewHeaderView.identifier) as! LevelTableViewHeaderView
        view.configureHeader(title: headerTitle[section])
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: LevelTableSectionFooterView.identifier) as! LevelTableSectionFooterView
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.adjusted
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 51.adjusted
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 33.adjusted
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return sectionLevelData[self.currentLevel].firstSection.count
        case 1:
            return sectionLevelData[self.currentLevel].secondSection.count
        case 2:
            return sectionLevelData[self.currentLevel].thirdSection.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LevelTableViewCell.identifier, for: indexPath) as? LevelTableViewCell ?? LevelTableViewCell()
        let index: Int
        switch indexPath.section {
        case 0:
            index = 0
            cell.configureCell(boolData: SecretNoteDTO.booleanDummy().grade1[index],
                               contentData: sectionLevelData[self.currentLevel].firstSection[indexPath.row])
        case 1:
            index = sectionLevelData[self.currentLevel].firstSection.count
            cell.configureCell(boolData:SecretNoteDTO.booleanDummy().grade1[index],
                               contentData: sectionLevelData[self.currentLevel].secondSection[indexPath.row])
        case 2:
            index = sectionLevelData[self.currentLevel].firstSection.count + sectionLevelData[self.currentLevel].secondSection.count
//            cell.configureCell(boolData:stateData?[indexPath.section][index] ?? Bool(),

            cell.configureCell(boolData:SecretNoteDTO.booleanDummy().grade1[index],
                               contentData: sectionLevelData[self.currentLevel].thirdSection[indexPath.row])
            
        default:
            return cell
        }

        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UIPickerView

extension LevelReportViewController: UIPickerViewDelegate {
    
}

extension LevelReportViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    // 피커 뷰 행의 넓이
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        levelReportView.configureLevelButton(text: pickerData[row])
        currentLevel = row
        levelReportView.levelReportTableView.reloadData()
        levelReportView.levelPickerView.isHidden = true // 선택 후 피커 뷰 숨기기
    }
}

// MARK: - Network

extension LevelReportViewController {
    private func getSecretNoteData() {
        self.reportProvider.request(.secretNote(month: 12, week: 1)) { response in
            switch response {
            case .success(let moyaResponse):
                do {
                    let responseData = try moyaResponse.map(GenericResponse<SecretNoteDTO>.self)
                    self.stateData?.append(responseData.result.grade1)
                    self.stateData?.append(responseData.result.grade2)
                    self.stateData?.append(responseData.result.grade3)

                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
