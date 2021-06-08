//
//  RecordWhistleViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/7.
//

import UIKit
import AVFoundation

class RecordWhistleViewController: UIViewController {
    
    private var recordingSession: AVAudioSession?
    private var whistleRecorder: AVAudioRecorder?
    private var whistlePlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Record your whistle"
        view.backgroundColor = .gray
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Record", style: .plain, target: nil, action: nil)
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession?.setCategory(.playAndRecord, mode: .default)
            try recordingSession?.setActive(true)
            
            recordingSession?.requestRecordPermission({ [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        self.loadFailUI()
                    }
                }
            })
        } catch {
            loadFailUI()
        }
    }
    
    // MARK: - getter
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return stackView
    }()
    
    private lazy var recordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tap to Record", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        button.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tap to Play", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        button.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var failLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "录音失败：请确保该应用可以访问您的麦克风。"
        label.numberOfLines = 0
        return label
    }()
}

// MARK: - AVAudioRecorderDelegate

extension RecordWhistleViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecord(success: false)
        }
    }
}

extension RecordWhistleViewController {
    private func loadRecordingUI() {
        stackView.addArrangedSubview(recordButton)
        stackView.addArrangedSubview(playButton)
    }
    
    private func loadFailUI() {
        stackView.addArrangedSubview(failLabel)
    }
}

extension RecordWhistleViewController {
    @objc private func nextTapped() {
        let vc = SelectGenreViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func recordTapped() {
        if whistleRecorder == nil {
            startRecording()
            
            if !playButton.isHidden {
                UIView.animate(withDuration: 0.35) {
                    self.playButton.isHidden = true
                    self.playButton.alpha = 0
                }
            }
        } else {
            finishRecord(success: true)
        }
    }
    
    @objc private func playTapped() {
        let audioURL = RecordWhistleViewController.getWhistleURL()
        
        do {
            whistlePlayer = try AVAudioPlayer(contentsOf: audioURL)
            whistlePlayer?.play()
        } catch {
            let alert = UIAlertController(title: "播放失败", message: "吹哨子有问题，请尝试重新录制。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "我知道了", style: .default))
            present(alert, animated: true)
        }
    }
    
    private func startRecording() {
        // 1.
        view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        
        // 2.
        recordButton.setTitle("Tap to Stop", for: .normal)
        
        // 3.
        let audioURL = RecordWhistleViewController.getWhistleURL()
        print("audio url = \(audioURL.absoluteString)")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            // 5.
            whistleRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            whistleRecorder?.delegate = self
            whistleRecorder?.record()
        } catch {
            finishRecord(success: false)
        }
    }
    
    private func finishRecord(success: Bool) {
        view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
        
        whistleRecorder?.stop()
        whistleRecorder = nil
        
        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
            
            if playButton.isHidden {
                UIView.animate(withDuration: 0.35) {
                    self.playButton.isHidden = false
                    self.playButton.alpha = 1
                }
            }
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            
            let alert = UIAlertController(title: "录音失败", message: "录制您的哨声时出现问题，请再试一次。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "我知道了", style: .default))
            present(alert, animated: true)
        }
    }
}

extension RecordWhistleViewController {
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func getWhistleURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent("whistle.m4a")
    }
}
