//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by MICK SOUMPHONPHAKDY on 11/9/16.
//  Copyright © 2016 MICK SOUMPHONPHAKDY. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
	
	// MARK: Properties
	var audioRecorder: AVAudioRecorder!
	
	
	// MARK IBOutlet
	@IBOutlet weak var statusLabel: UILabel!
	@IBOutlet weak var recordButtonLabel: UIButton!
	@IBOutlet weak var stopRecordButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		stopRecordButton.isEnabled = false
	}
	
	override func viewWillAppear(_ animated: Bool) {
		print("View Appear Called")
	}

	@IBAction func recordAudio(_ sender: Any) {
		statusLabel.text = "Recording In Progress..."
		recordButtonLabel.isEnabled = false
		stopRecordButton.isEnabled = true
		
		// set the directory path where the recording file will be saved
		let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
		let recordingName = "recordedVoice.wav"
		let pathArray = [dirPath, recordingName]
		let filePath = URL(string: pathArray.joined(separator: "/"))
		print(filePath!)
		
		// create a shared session for AVAudio
		let session = AVAudioSession.sharedInstance()
		try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)

		// Instantiate an audio Recorder
		// set the properties
		try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
		audioRecorder.delegate = self
		audioRecorder.isMeteringEnabled = true
		audioRecorder.prepareToRecord()
		audioRecorder.record()
	}
	
	@IBAction func stopRecording(_ sender: Any) {
		print("Stop Record Button Pressed")
		stopRecordButton.isEnabled = false
		recordButtonLabel.isEnabled = true
		statusLabel.text = "Recording has stop"
		audioRecorder.stop()
		let audioSession = AVAudioSession.sharedInstance()
		try! audioSession.setActive(false)
	}
	
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		if flag {
			performSegue(withIdentifier: "stopRecordingSegue", sender: audioRecorder.url)
		} else {
			print("recording was not successful")
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "stopRecordingSegue" {
			let playSoundsVC = segue.destination as! PlaySoundsViewController
			let recordedAudioURL = sender as! URL
			playSoundsVC.recordedAudioURL = recordedAudioURL
		}
	}
	

}

