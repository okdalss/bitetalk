//
//  VoiceViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 24/05/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    let audioSessionRecord = AudioSessionandRecord()
    var avAudioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nextButton.isHidden = true
        playButton.isHidden = true
        audioSessionRecord.activatingAudioSession()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleRecord(_ sender: UIButton) {
        if sender.title(for: .normal) == "record" || sender.title(for: .normal) == "record again" {
            audioSessionRecord.startRecording()
            recordButton.setTitle("pause", for: .normal)
            playButton.isHidden = true
            nextButton.isHidden = true
        } else {
            audioSessionRecord.finishRecording(success: true)
            audioSessionRecord.fileManage()
//            UserSetting.shared().voice = audioSessionRecord.audioFile
            UserDefaults.standard.set(audioSessionRecord.audioFile, forKey: "voice")
            recordButton.setTitle("record again", for: .normal)
            playButton.isHidden = false
            nextButton.isHidden = false 
        }
    }
    
    @IBAction func handlePlay(_ sender: UIButton) {
        if let voiceFile = audioSessionRecord.audioFile {
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
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playButton.isEnabled = true
    }
    
    @IBAction func hadleDone(_ sender: UIButton) {
        
    }
    
    @IBAction func handlePrevious(_ sender: UIButton) {
        dismiss(animated: true) {
//            UserSetting.shared().voice = nil
            UserDefaults.standard.set(nil, forKey: "voice")
        }
    }
    
    
}
