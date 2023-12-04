//
//  UsingWordViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

struct UsingWord {
    let day: String
    let wordCount: Int
}

final class UsingWordViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let usingWordView = UsingWordView()
    private var wordData: [UsingWord] = [UsingWord(day: "2023-12-01", wordCount: 11),
                                         UsingWord(day: "2023-12-02", wordCount: 14),
                                         UsingWord(day: "2023-12-03", wordCount: 9),
                                         UsingWord(day: "2023-12-04", wordCount: 12),
                                         UsingWord(day: "2023-12-05", wordCount: 0),
                                         UsingWord(day: "2023-12-06", wordCount: 0),
                                         UsingWord(day: "2023-12-07", wordCount: 0),]
    let pickerData = ["2023년 12월 1주차", "22023년 12월 2주차", "2023년 12월 3주차"]
    var date: [String] = ["10-02", "10-03", "10-04", "10-06", "10-07" ,"10-09"]
    var wordCount: [Double] = [5, 12, 7, 13, 2, 7]
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setViewGesture()
        setDelegate()
        setCharts()
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
    
    private func setCharts() {
        usingWordView.setCharts(data: wordData)
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        usingWordView.configureMonthButton(text: pickerData[row])
        usingWordView.monthPickerView.isHidden = true // 선택 후 피커 뷰 숨기기
    }
}
