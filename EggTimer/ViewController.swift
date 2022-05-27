//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Hard": 12*60, "Medium": 7*60, "Soft": 5*60]
    var timer = Timer()
    var totalTime = 0
    var timePassed = 0
    var player = AVAudioPlayer()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        self.progressBar.progress = 0
        self.timePassed = 0
        
        let hardness = sender.currentTitle!
        self.titleLabel.text = hardness
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.timePassed < self.totalTime {
                self.timePassed += 1
                let progress = Float(self.timePassed) / Float(self.totalTime)
                self.progressBar.progress = progress
            } else {
                Timer.invalidate()
                self.titleLabel.text = "Done!"
                self.playSound()
            }
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
