//
//  VoiceInitViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 19/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceInitViewController: UIViewController, AVAudioPlayerDelegate {
    
    let audioSessionRecorder = AudioSessionandRecord()
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    var avAudioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleRecord(_ sender: UIButton) {
        audioSessionRecorder.activatingAudioSession()
        if sender.title(for: .normal) == "record" {
            audioSessionRecorder.startRecording()
            recordButton.setTitle("pause", for: .normal)
        } else {
            audioSessionRecorder.finishRecording(success: true)
            audioSessionRecorder.fileManage()
            recordButton.setTitle("record", for: .normal)
        }
    }
    
    @IBAction func handlePlay(_ sender: UIButton) {
        if let voiceFile = audioSessionRecorder.audioFile {
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
}
