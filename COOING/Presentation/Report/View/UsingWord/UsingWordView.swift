//
//  UsingWordView.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/03.
//

import UIKit

import Charts
import DGCharts
import SnapKit
import Then

final class UsingWordView: BaseView {
    
    // MARK: - Properties
    
    var monthStackViewHandler: (() -> (Void))?
    
    // MARK: - UI Components
    
    private let wordTitleLabel = UILabel()
    private let wordSubTitleLabel = UILabel()
    private let monthButton = UIButton()
    private let monthLabel = UILabel()
    private lazy var monthStackView = UIStackView(arrangedSubviews: [monthButton, monthLabel])
    var monthPickerView = UIPickerView()
    var wordChart = BarChartView()
    private var bottomLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setGestureRecognizer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions

    override func configureUI() {
        wordTitleLabel.do {
            $0.text = "사용단어"
            $0.font = .title2()
            $0.textColor = .cooingBrown
        }
        
        wordSubTitleLabel.do {
            $0.text = "Jiwoo가 말한 단어 수의 변화예요."
            $0.font = .body3()
            $0.textColor = .cooingBrown
        }
        
        monthButton.do {
            $0.setImage(Image.selectLevel, for: .normal)
        }
        
        monthLabel.do {
            $0.text = "2023년 12월 1주차"
            $0.font = .body3()
            $0.textColor = .cooingBrown.withAlphaComponent(0.7)
        }
        
        monthStackView.do {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.alignment = .center
        }
        
        monthPickerView.do {
            $0.backgroundColor = .lightGray
            $0.isHidden = true
        }
        
        wordChart.do {
            $0.noDataText = "아직 데이터가 없어요!"
            $0.noDataFont = .body3()
            $0.noDataTextColor = .cooingBrown
            $0.doubleTapToZoomEnabled = false
            $0.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
            $0.layer.cornerRadius = 20
            $0.xAxis.gridColor = .cooingGray1
            $0.xAxis.labelTextColor = .cooingGray1
        }
        
        bottomLabel.do {
            $0.font = .body3()
            $0.text = "2023년 12월 1주차에는 평균 19개의 단어를 사용했어요!"
            $0.textColor = .cooingBrown
        }
    }
    
    override func hieararchy() {
        self.addSubViews(wordTitleLabel,
                         wordSubTitleLabel,
                         monthStackView,
                         monthPickerView,
                         wordChart,
                         bottomLabel)
    }
    
    override func setLayout() {
        
        wordTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(33.adjusted)
        }
        
        wordSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(wordTitleLabel.snp.bottom).offset(5.adjusted)
            $0.leading.equalTo(wordTitleLabel)
        }
        
        monthButton.snp.makeConstraints {
            $0.height.width.equalTo(20.adjusted)
        }
        
        monthPickerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(180.adjusted)
        }
        
        monthStackView.snp.makeConstraints {
            $0.top.equalTo(wordSubTitleLabel.snp.bottom).offset(35.adjusted)
            $0.leading.equalTo(wordTitleLabel)
        }
        
        wordChart.snp.makeConstraints {
            $0.top.equalTo(monthStackView.snp.bottom).offset(34.adjusted)
            $0.leading.trailing.equalToSuperview().inset(30.adjusted)
            $0.height.equalTo(250.adjusted)
        }
        
        bottomLabel.snp.makeConstraints {
            $0.top.equalTo(wordChart.snp.bottom).offset(26.adjusted)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setGestureRecognizer() {
        let monthStackViewTappedGesture = UITapGestureRecognizer(target: self, action: #selector(monthStackViewDidTapped))
        monthStackView.addGestureRecognizer(monthStackViewTappedGesture)
    }
    
    @objc
    private func monthStackViewDidTapped() {
        monthStackViewHandler?()
    }
    
    func configureMonthButton(text: String) {
        monthLabel.text = text
    }
    
    func convertDateFormat(from dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MM.dd"

        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func setCharts(data: [UsingWord]) {
        var dataEntries: [BarChartDataEntry] = []
        var dataPoints: [String] = []
        for i in 0..<data.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(data[i].wordCount))
            dataEntries.append(dataEntry)
            guard let reformatDate = convertDateFormat(from: data[i].day) else { return }
            dataPoints.append(reformatDate)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "단어 수")
        
        // 차트 컬러
        chartDataSet.colors = [.cooingYellow]
        chartDataSet.valueFont = .body5()
        
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.3
        chartData.setValueTextColor(.cooingGray1)
        chartData.setValueFont(.body5())
        wordChart.data = chartData
        wordChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        wordChart.xAxis.labelPosition = .bottom
        wordChart.rightAxis.enabled = false
        wordChart.leftAxis.axisMinimum = 0
        wordChart.leftAxis.gridColor = .cooingGray1
        wordChart.leftAxis.labelTextColor = .cooingGray1
        wordChart.leftAxis.labelFont = .body5()
        wordChart.legend.textColor = .cooingGray1
        wordChart.legend.font = .body5()
    }
}
