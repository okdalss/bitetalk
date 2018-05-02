//
//  VoiceInitViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 19/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceInitViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder?
    var audioFilename: URL?
    var avAudioPlayer: AVAudioPlayer?
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton.isEnabled = false
        playButton.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        //                        self.loadRecordingUI()
                        self.recordButton.isEnabled = true
                        print(self.recordingSession.currentRoute)
                        print(self.recordingSession.sampleRate)
                    } else {
                        // failed to record!
                        print("faild to record!")
                    }
                }
            }
        } catch {
            // failed to record!
            print("faild to record!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleRecord(_ sender: UIButton) {
        if sender.title(for: .normal) == "Record" {
            startRecording()
            recordButton.setTitle("Pause", for: .normal)
            playButton.isEnabled = false
        } else if sender.title(for: .normal) == "Pause" {
            finishRecording(success: true)
            fileManage()
            UserSetting.shared().voice = audioFilename
            recordButton.setTitle("Record", for: .normal)
            playButton.isHidden = false
            playButton.isEnabled = true
        }
    }
    
    @IBAction func handlePlay(_ sender: UIButton) {
        if let voiceFile = audioFilename {
            do {
                avAudioPlayer = try AVAudioPlayer(contentsOf: voiceFile)
                avAudioPlayer?.delegate = self
                avAudioPlayer?.prepareToPlay()
                avAudioPlayer?.play()
                if (avAudioPlayer?.isPlaying)! {
                    playButton.isEnabled = false
                }
            } catch { print("can not play") }
        }
    }
    
    func startRecording() {
        audioFilename = getDocumentsDirectory()
            .appendingPathComponent("my_recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(
                url: audioFilename!, settings: settings)
            print("audioRecorder:::::::::: \(audioRecorder)")
            audioRecorder?.delegate = self
            audioRecorder?.record()
        } catch {
//            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for:
            .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func finishRecording(success: Bool) {
        audioRecorder?.stop()
        audioRecorder = nil
        
        if success {
            // recording finished
        } else {
            // recording failed
        }
    }
    
    func fileManage() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print("File Location:", paths.path)
        
        if FileManager.default.fileExists(atPath: paths.path) {
            print("file found and ready to play")
        } else {
            print("no file")
        }
    }
    
    func audioRecorderDidFinishRecording(
        _ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playButton.isEnabled = true
    }
}
