//
//  ReportViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

import Moya

class ReportViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let reportProvider = MoyaProvider<ReportRouter>(plugins: [MoyaLoggingPlugin()])
    private var name: String = String()
    
    // MARK: - UI Components
    
    private let reportView = ReportView()
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setViewGesture()
        
        print("year: \(CurrentDate.year)")
        print("month: \(CurrentDate.month)")
        print("day: \(CurrentDate.day)")
        print("week: \(CurrentDate.week)")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkFunctions()
    }
    
    // MARK: - Functions

    override func configureUI() {
        
    }

    override func hieararchy() {
        self.view.addSubview(reportView)
    }

    override func setLayout() {
        reportView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setButtonEvent() {
        //override Point
    }
    
    private func setViewGesture() {
        reportView.frequentWordHandler = {[weak self] in
            guard let self else { return }
            let frequentWordViewController = FrequentWordViewController()
            frequentWordViewController.setName(name: name)
            self.navigationController?.pushViewController(frequentWordViewController, animated: true)
        }
        
        reportView.secretNoteHandler = {[weak self] in
            guard let self else { return }
            let secretNoteViewController = SecretNoteViewController()
            secretNoteViewController.setName(name: name)
            self.navigationController?.pushViewController(secretNoteViewController, animated: true)
        }
        
        reportView.usingWordHandler = {[weak self] in
            guard let self else { return }
            let usingWordViewController = UsingWordViewController()
            usingWordViewController.setName(name: name)
            self.navigationController?.pushViewController(usingWordViewController, animated: true)
        }
    }
    
    private func networkFunctions() {
        getInfoData()
        getTotalData()
    }
}

// MARK: - Network

extension ReportViewController {
    private func getInfoData() {
        self.reportProvider.request(.info) { response in
            switch response {
            case .success(let moyaResponse):
                do {
                    let responseData = try moyaResponse.map(GenericResponse<InfoDTO>.self)
                    self.reportView.configureInfoView(data: responseData.result)
                    self.name = responseData.result.name
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    private func getTotalData() {
        self.reportProvider.request(.total) { response in
            switch response {
            case .success(let moyaResponse):
                do {
                    let responseData = try moyaResponse.map(GenericResponse<ReportTotalDTO>.self)
                    self.reportView.reportSummaryView.configureSummaryView(data: responseData.result)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
