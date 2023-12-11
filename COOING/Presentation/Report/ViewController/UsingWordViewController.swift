//
//  UsingWordViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import Moya

final class UsingWordViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let reportProvider = MoyaProvider<ReportRouter>(plugins: [MoyaLoggingPlugin()])
    private var name: String = String()
    private var averageWord: Int = Int()
    private var wordData: [WordNum] = [] {
        didSet {
            usingWordView.setCharts(data: wordData)
        }
    }
    let pickerData = ["\(CurrentDate.year)년 \(CurrentDate.month)월 1주차",
                      "\(CurrentDate.year)년 \(CurrentDate.month)월 2주차",
                      "\(CurrentDate.year)년 \(CurrentDate.month)월 3주차",
                      "\(CurrentDate.year)년 \(CurrentDate.month)월 4주차"]
    
    // MARK: - UI Components
    
    private let usingWordView = UsingWordView()
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
//        setViewGesture()
        setDelegate()
        getUsingWordData(year: CurrentDate.year, month: CurrentDate.month, week: CurrentDate.week)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUsingWordData(year: CurrentDate.year, month: CurrentDate.month, week: CurrentDate.week)
    }
    
    // MARK: - Functions

    override func configureUI() {
        
    }

    override func hieararchy() {
        self.view.addSubview(usingWordView)
    }

    override func setLayout() {
        usingWordView.snp.makeConstraints {
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
    
    private func setViewGesture() {
        usingWordView.monthStackViewHandler = { [weak self] in
            guard let self else { return }
            self.usingWordView.monthPickerView.isHidden = false
        }
    }
    
    private func setDelegate() {
        usingWordView.monthPickerView.delegate = self
        usingWordView.monthPickerView.dataSource = self
    }
    
    func setName(name: String) {
        usingWordView.wordSubTitleLabel.text = "\(name)이(가) 말한 단어 수의 변화에요."
    }
}

extension UsingWordViewController: UIPickerViewDelegate {
    
}

extension UsingWordViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    // 피커 뷰 행의 넓이
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 250
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
}

extension UsingWordViewController {
    private func getUsingWordData(year: Int, month: Int, week: Int) {
        self.reportProvider.request(.usingWord(year: CurrentDate.year,
                                               month: CurrentDate.month,
                                               week: CurrentDate.week)) { response in
            switch response {
            case .success(let moyaResponse):
                do {
                    let responseData = try moyaResponse.map(GenericResponse<UsingWordDTO>.self)
                    self.wordData = responseData.result.wordNum
                    self.usingWordView.bottomLabel.text = "\(CurrentDate.year)년 \(CurrentDate.month)월 \(CurrentDate.week)주차에는 평균 \(responseData.result.averageWordNum)개의 단어를 사용했어요!"
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
