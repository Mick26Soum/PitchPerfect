//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by MICK SOUMPHONPHAKDY on 11/9/16.
//  Copyright © 2016 MICK SOUMPHONPHAKDY. All rights reserved.
//  TODO: Incorporate Alexa into this app with skill set to sounds like snoop
//  TODO: Review Size Classes in depth - with regards to size classes and Axis Orientation:
//  Source: https://discussions.udacity.com/t/pitch-perfect-ui-elements-appear-squished-together/169289/23
//  Sourc: UIAlert - http://nshipster.com/uialertcontroller/


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

		// encapsulate button and status label function
		configureRecordingButton(recording: true)
		
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
		configureRecordingButton(recording: false)
		audioRecorder.stop()
		let audioSession = AVAudioSession.sharedInstance()
		try! audioSession.setActive(false)
		
	}
	
	func configureRecordingButton(recording: Bool){
		
		statusLabel.text = recording ? "Recording In Progress..." : " Recording has stopped"
		recordButtonLabel.isEnabled = !recording
		stopRecordButton.isEnabled = recording
		
	}
	
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		
		if flag {
			performSegue(withIdentifier: "stopRecordingSegue", sender: audioRecorder.url)
		} else {
			let alertViewController = UIAlertController.init(title: "Oops", message: "Recording was unsuccessful. Please try again.", preferredStyle: .alert)
			let OKAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
			alertViewController.addAction(OKAction)
			self.present(alertViewController, animated: true, completion: nil)
			// Refactor code to create an alert helper
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

