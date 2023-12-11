//
//  HistoryViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

import Moya

final class HistoryViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var historyProvider = MoyaProvider<HistoryRouter>(plugins: [MoyaLoggingPlugin()])
    let pickerMonth = ["12월"]
    private let dummyData: [HistoryData] = [HistoryData(date: "12/1", text: "오늘 학교 점심 맛있겠다"),
                                            HistoryData(date: "12/2", text: "오늘 점심에 친구 만났어. 오늘 학교 갔어"),
                                            HistoryData(date: "12/3", text: "오늘 오늘 점심 뭐먹지. 오늘 점심 학식 먹어야지"),
                                            HistoryData(date: "12/4", text: "오늘 엄마가 학교에 데리러 와줬으면 좋겠다. 엄마 보고싶다"),]
    private var responseData: [HistoryListDTO]?
    
    // MARK: - UI Components
    
    private let historyView = HistoryView()
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setTableView()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getHistoryListData()
    }
    
    // MARK: - Functions

    override func hieararchy() {
        self.view.addSubview(historyView)
    }

    override func setLayout() {
        historyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setButtonEvent() {
        historyView.monthStackViewHandler = { [weak self] in
            guard let self else { return }
            self.historyView.monthPickerView.isHidden = false
        }
    }
    
    override func customNavigationBar() {
        navigationController?.navigationBar.tintColor = .cooingBrown2
        let backButton: UIBarButtonItem = UIBarButtonItem()
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationItem.title = "모아보기"
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.button1(),
            NSAttributedString.Key.foregroundColor: UIColor.cooingBrown2
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }
    
    private func setTableView() {
        historyView.historyTableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
    }
    
    private func setDelegate() {
        historyView.monthPickerView.delegate = self
        historyView.monthPickerView.dataSource = self
        
        historyView.historyTableView.dataSource = self
        historyView.historyTableView.delegate = self
    }
}

extension HistoryViewController: UITableViewDelegate {}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell ?? HistoryTableViewCell()
        cell.selectionStyle = .none
        cell.configureCell(data: responseData?[indexPath.row] ?? HistoryListDTO(answerID: Int(),
                                                                                content: "",
                                                                                createAt: ""))
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78.adjusted
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let historyDetailViewController = HistoryDetailViewController()
        historyDetailViewController.bindAnswerID(id: responseData?[indexPath.row].answerID ?? 0)
        navigationController?.pushViewController(historyDetailViewController, animated: true)
    }
}

extension HistoryViewController: UIPickerViewDelegate {
    
}

extension HistoryViewController: UIPickerViewDataSource {
    
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
        return pickerMonth.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerMonth[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        historyView.configureMonthButton(text: pickerMonth[row])
        historyView.historyTableView.reloadData()
        historyView.monthPickerView.isHidden = true // 선택 후 피커 뷰 숨기기
    }
}

extension HistoryViewController {
    private func getHistoryListData() {
        self.historyProvider.request(.historyList(year: CurrentDate.year, month: CurrentDate.month)) { response in
            switch response {
            case .success(let moyaResponse):
                do {
                    let responseData = try moyaResponse.map(GenericResponse<[HistoryListDTO]>.self)
                    print("\(responseData) 💡💡")
                    self.responseData = responseData.result
                    self.historyView.historyTableView.reloadData()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
