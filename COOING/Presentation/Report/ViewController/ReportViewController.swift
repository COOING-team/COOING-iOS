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
    
    // MARK: - UI Components
    
    private let reportView = ReportView()
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setViewGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        networkFunctions()
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
            self.navigationController?.pushViewController(frequentWordViewController, animated: true)
        }
        
        reportView.secretNoteHandler = {[weak self] in
            guard let self else { return }
            let secretNoteViewController = SecretNoteViewController()
            self.navigationController?.pushViewController(secretNoteViewController, animated: true)
        }
        
        reportView.usingWordHandler = {[weak self] in
            guard let self else { return }
            let usingWordViewController = UsingWordViewController()
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
