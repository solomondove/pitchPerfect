//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Solomon Dove on 11/30/21.
//  Copyright © 2021 SolomonDove. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppeared called")
    }
    
    
    @IBAction func recordAudio(_ sender: Any) {
        configureUi(setMessage: "Recording in Progress", enableRecordButton: false, enableStopRecordButton: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
       
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [ : ])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
//        audioRecorder.prepareToRecord()
        audioRecorder.record()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("finished Recording")
    }
    
    func configureUi(setMessage labelText: String, enableRecordButton isRecordButtonEnabled: Bool, enableStopRecordButton isStopRecordButtonEnabled: Bool) {
        recordingLabel.text = labelText
        recordButton.isEnabled = isRecordButtonEnabled
        stopRecordingButton.isEnabled = isStopRecordButtonEnabled
    }
}

