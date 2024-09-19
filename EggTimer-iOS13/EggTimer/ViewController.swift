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
    // MARK: - Properties
    let eggsLevel = ["Soft": 3, "Medium": 4, "Hard": 7]
    var secondPassing = 0
    var totalTime = 0
    var timer = Timer()
    @IBOutlet weak var eggTiltle: UILabel!
    @IBOutlet weak var timeProgress: UIProgressView!
    var player:AVAudioPlayer?
    
    // MARK: - Action Button
    @IBAction func hardnessSelceted(_ sender: UIButton) {
        timer.invalidate()
        secondPassing = 0
        timeProgress.progress = 0.0
        totalTime = eggsLevel[sender.currentTitle ?? ""] ?? 0
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    // MARK: - Create Fuction For Update Time and progess bar.
    @objc func updateTime() {
        
        if secondPassing < totalTime {
            secondPassing += 1
            timeProgress.progress = Float(secondPassing) / Float(totalTime)
            
        }
        
        else {
            timer.invalidate()
            if secondPassing == 3 {
                eggTiltle.text = "Soft Egg Prepare"
                playAudio()
                
            }
            else if secondPassing == 4 {
                eggTiltle.text = "Medium Egg Prepare"
                playAudio()
                
            }
            
            else {
                eggTiltle.text = "Hard Egg Prepare"
                playAudio()
                
            }
        }
    }
    
    // MARK: - Create Fuction For play Audio.
    func playAudio() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
}
