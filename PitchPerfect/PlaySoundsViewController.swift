//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by MICK SOUMPHONPHAKDY on 11/14/16.
//  Copyright © 2016 MICK SOUMPHONPHAKDY. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
	
	// MARK: IBOutlets
	@IBOutlet weak var snailButton:UIButton!
	@IBOutlet weak var rabbitButton:UIButton!
	@IBOutlet weak var squirrelButton:UIButton!
	@IBOutlet	weak var darthVaderButton:UIButton!
	@IBOutlet weak var birdButton:UIButton!
	@IBOutlet weak var reverbButton:UIButton!
	@IBOutlet weak var stopButton:UIButton!
	
	// MARK: - Properties
	var recordedAudioURL: URL!
	
	// MARK: Audio Extension Variables
	var audioFile:AVAudioFile!
	var audioEngine:AVAudioEngine!
	var audioPlayerNode: AVAudioPlayerNode!
	var stopTimer: Timer!
	
	enum ButtonType: Int {
		case slow = 0, fast, chipmunk, vader, bird, reverb
	}
	
	// MARK: IBAction
	@IBAction func playSoundForButton(_ sender: UIButton){
		print("Play Sound Func Triggered")
		switch(ButtonType(rawValue: sender.tag)!) {
			case .slow:
			playSound(rate: 0.5)
			case .fast:
			playSound(rate: 1.5)
			case .chipmunk:
			playSound(pitch: 1000)
			case .vader:
			playSound(pitch: -1000)
			case .bird:
			playSound(bird: true)
			case .reverb:
			playSound(reverb: true)
		}
		
		configureUI(.playing)
	}
	
	@IBAction func stopButtonPressed(_ sender: UIButton){
		print("Stop Button Pressed")
		stopAudio()
	}

	override func viewDidLoad() {
		
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setupAudio()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		configureUI(.notPlaying)
		
	}

	override func didReceiveMemoryWarning() {
		
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
		
	}

}
