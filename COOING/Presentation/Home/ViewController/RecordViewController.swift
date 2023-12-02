//
//  RecordViewController.swift
//  COOING
//
//  Created by 최지우 on 11/6/23.
//

import AVFoundation
import UIKit

class RecordViewController: BaseViewController,AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
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
        let transformRecordViewController = TransformRecordViewController()
        navigationController?.pushViewController(transformRecordViewController, animated: true)
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

    }
    
    override func setLayout() {
        recordView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
