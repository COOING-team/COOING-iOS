//
//  HistoryDetailViewController.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/09.
//

import AVFoundation
import UIKit

import Moya

final class HistoryDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var historyProvider = MoyaProvider<HistoryRouter>(plugins: [MoyaLoggingPlugin()])
    private var id: Int = Int()
    private var year: String = String()
    
    // MARK: - UI Components
    
    let historyDetailView = HistoryDetailView()
    private var audioPlayer: AVPlayer?
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getHistoryDetailData()
    }
    
    // MARK: - override Functions
    
    override func hieararchy() {
        view.addSubview(historyDetailView)
    }
    
    override func configureUI() {
        super.configureUI()
        
    }
    
    override func setLayout() {
        historyDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setButtonEvent() {
        historyDetailView.transformButton.addTarget(self, action: #selector(playButtonDidTapped), for: .touchUpInside)
    }
    
    func bindAnswerID(id: Int) {
        self.id = id
    }
    
    @objc
    private func playButtonDidTapped() {
        if historyDetailView.transformButton.isUserInteractionEnabled {
            audioPlayer?.play()
        } else {
            showAlert(title: "이 날 저장된 음성이 없어요!", text: "다른 기록들을 확인해주세요", style: .default)
        }
    }
    
    func setupPlayer(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)
    }
    
    // MARK: - Custom Method
    
}

extension HistoryDetailViewController {
    private func getHistoryDetailData() {
        self.historyProvider.request(.historyDetail(id: self.id)) { response in
            switch response {
            case .success(let moyaResponse):
                do {
                    let responseData = try moyaResponse.map(GenericResponse<HistoryDetailDTO>.self)
                    self.historyDetailView.bindData(data: responseData.result)
                    if let audioUrl = URL(string: responseData.result.fileURL) {
                        self.setupPlayer(url: audioUrl)
                        self.historyDetailView.transformButton.isUserInteractionEnabled = true
                    } else {
                        self.historyDetailView.transformButton.isUserInteractionEnabled = false
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
