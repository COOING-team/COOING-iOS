//
//  RecordViewController.swift
//  COOING
//
//  Created by 최지우 on 11/6/23.
//

import UIKit

import AVFoundation
import Moya

class RecordViewController: BaseViewController,AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    // MARK: - Properties
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    let provider = MoyaProvider<ClovaSpeechService>()
    static let recordProvider = MoyaProvider<RecordRouter>(plugins: [MoyaLoggingPlugin()])

    
    // MARK: - UI Components
    
    private let recordView = RecordView()

    // MARK: - override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
        setupButtons()
    }
    
    func setupRecorder() {
        let fileMgr = FileManager.default
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        let soundFileURL = dirPaths[0].appendingPathComponent("sound.caf")
        
        let recordSettings = [
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
        ] as [String: Any]
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioRecorder = AVAudioRecorder(url: soundFileURL, settings: recordSettings)
            audioRecorder?.delegate = self
            audioRecorder?.prepareToRecord()
        } catch {
            print("audioSession error: \(error.localizedDescription)")
        }
    }
    
    func setupButtons() {
 
        recordView.recordButton.addTarget(self, action: #selector(recordAudio), for: .touchUpInside)
        recordView.reRecordButton.addTarget(self, action: #selector(stopAudio), for: .touchUpInside)
        recordView.listenButton.addTarget(self, action: #selector(startAudio), for: .touchUpInside)
        recordView.nextButton.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)

        // Initially disable stop and play buttons
        recordView.reRecordButton.isEnabled = false
        recordView.listenButton.isEnabled = false

    }
    
    @objc func recordAudio() {
        if audioRecorder?.isRecording == false {
            recordView.listenButton.isEnabled = false
            recordView.reRecordButton.isEnabled = true
            audioRecorder?.record()
        }
    }
    
    @objc func stopAudio() {
        recordView.reRecordButton.isEnabled = false
        recordView.listenButton.isEnabled = true
        recordView.recordButton.isEnabled = true
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
    }
    
    @objc func startAudio() {
        if audioRecorder?.isRecording == false {
            recordView.reRecordButton.isEnabled = true
            recordView.recordButton.isEnabled = false
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: audioRecorder!.url)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func tappedNextButton() {
        
        processRecordedAudio()
        
        
    }

    // MARK: - AVAudioPlayerDelegate Methods
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordView.recordButton.isEnabled = true
        recordView.reRecordButton.isEnabled = false
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }

    // MARK: - AVAudioRecorderDelegate Methods
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
    }

    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Audio Record Encode Error")
    }
    
    // Handle memory warnings
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func hieararchy() {
        view.addSubview(recordView)
    }
    
    override func configureUI() {
        super.configureUI()

    }
    
    override func setLayout() {
        recordView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
}

// MARK: - ClovaSpeechService

extension RecordViewController {

    // MARK: - AVAudioRecorderDelegate Methods
    func convertAudioToWAV(audioURL: URL, completion: @escaping (Result<URL, Error>) -> Void) {
            let exportSession = AVAssetExportSession(asset: AVAsset(url: audioURL), presetName: AVAssetExportPresetPassthrough)
            
            let filename = NSUUID().uuidString + ".wav"
            let outputPath = NSTemporaryDirectory() + filename
            let outputURL = URL(fileURLWithPath: outputPath)
            
            exportSession?.outputURL = outputURL
            exportSession?.outputFileType = AVFileType.wav
            
            exportSession?.exportAsynchronously {
                guard exportSession?.status == .completed else {
                    if let error = exportSession?.error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(NSError(domain: "ExportError", code: -1, userInfo: nil)))
                    }
                    return
                }
                completion(.success(outputURL))
            }
        }

        func sendAudioFile(audioURL: URL) {
            do {
                let audioData = try Data(contentsOf: audioURL)
                provider.request(.recognizeAudio(audioData: audioData, language: "Kor")) { result in
                    switch result {
                    case .success(let response):
                        
                        self.handleResponse(data: response.data) { recognizedResponse in
                            let transformRecordViewController = TransformRecordViewController()
                            transformRecordViewController.transformRecordView.answerTextView.text = recognizedResponse.text
                            self.navigationController?.pushViewController(transformRecordViewController, animated: true)
                        }
                    case .failure(let error):
                        print("Error sending audio file: \(error)")
                    }
                }
            } catch {
                print("Error reading audio file data: \(error)")
            }
        }
    
    // 녹음 완료 후 호출
    func processRecordedAudio() {
        guard let audioURL = audioRecorder?.url else { return }
        convertAudioToWAV(audioURL: audioURL) { [weak self] result in
            switch result {
            case .success(let convertedURL):
                self?.uploadRecordedAudio(audioData: convertedURL)
                self?.sendAudioFile(audioURL: convertedURL)
            case .failure(let error):
                print("Audio conversion error: \(error)")
            }
        }
    }
    
    func handleResponse(data: Data, completion: @escaping (SpeechRecognitionResponse) -> Void) {
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(SpeechRecognitionResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    
}


// MARK: - Network
extension RecordViewController {
    func uploadRecordedAudio(audioData: URL) {
           do {
               let data = try Data(contentsOf: audioData)
               RecordViewController.recordProvider.request(.uploadAudioURL(data)) { result in
                   switch result {
                   case .success(let response):
                       print("Audio uploaded successfully. Response: \(response)")
                       // Handle successful upload if needed
                   case .failure(let error):
                       print("Error uploading audio: \(error)")
                       // Handle error if needed
                   }
               }
           } catch {
               print("Error converting audio URL to Data: \(error)")
           }
       }
}
