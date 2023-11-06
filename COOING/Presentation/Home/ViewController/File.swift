//
//  File.swift
//  COOING
//
//  Created by 최지우 on 11/6/23.
//

//
//  ViewController.swift
//  cooing
//
//  Created by 최지우 on 11/6/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    var recordButton: UIButton!
    var stopButton: UIButton!
    var playButton: UIButton!
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?

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
        recordButton = UIButton(type: .system)
        recordButton.setTitle("Record", for: .normal)
        recordButton.addTarget(self, action: #selector(recordAudio), for: .touchUpInside)

        stopButton = UIButton(type: .system)
        stopButton.setTitle("Stop", for: .normal)
        stopButton.addTarget(self, action: #selector(stopAudio), for: .touchUpInside)
        
        playButton = UIButton(type: .system)
        playButton.setTitle("Play", for: .normal)
        playButton.addTarget(self, action: #selector(startAudio), for: .touchUpInside)

        // Initially disable stop and play buttons
        stopButton.isEnabled = false
        playButton.isEnabled = false

        // Add buttons to the view
        view.addSubview(recordButton)
        view.addSubview(stopButton)
        view.addSubview(playButton)

        // Layout buttons here or by overriding viewDidLayoutSubviews()
        // For example, if you are using Auto Layout, set the constraints here.
    }

    @objc func recordAudio() {
        if audioRecorder?.isRecording == false {
            playButton.isEnabled = false
            stopButton.isEnabled = true
            audioRecorder?.record()
        }
    }
    
    @objc func stopAudio() {
        stopButton.isEnabled = false
        playButton.isEnabled = true
        recordButton.isEnabled = true
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
    }
    
    @objc func startAudio() {
        if audioRecorder?.isRecording == false {
            stopButton.isEnabled = true
            recordButton.isEnabled = false
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

    // MARK: - AVAudioPlayerDelegate Methods
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        stopButton.isEnabled = false
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
    
    // Override this method to layout your subviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set the frames for buttons here
        // This is a placeholder layout, replace with your own
        let buttonSize = CGSize(width: 100, height: 50)
        recordButton.frame = CGRect(x: (view.bounds.width - buttonSize.width) / 2,
                                    y: view.bounds.height * 0.4,
                                    width: buttonSize.width,
                                    height: buttonSize.height)
        
        stopButton.frame = CGRect(x: (view.bounds.width - buttonSize.width) / 2,
                                  y: view.bounds.height * 0.5,
                                  width: buttonSize.width,
                                  height: buttonSize.height)
        
        playButton.frame = CGRect(x: (view.bounds.width - buttonSize.width) / 2,
                                  y: view.bounds.height * 0.6,
                                  width: buttonSize.width,
                                  height: buttonSize.height)
    }

    // Handle memory warnings
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
