//
//  ViewController.swift
//  AudioKit-HelloWorld
//
//  Created by Nathan Billis on 10/08/2019.
//  Copyright © 2019 Nathan Billis. All rights reserved.
//

import UIKit
import AudioKit
import CoreMotion

class ViewController: UIViewController {
    
    var oscillator = AKOscillator()
    var oscillator2 = AKOscillator()
    
    let motionManager = CMMotionManager()
    var timer: Timer!

    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if oscillator.isPlaying {
            oscillator.stop()
            oscillator.stop()
            sender.setTitle("Play Sine Wave", for: .normal)
        }
        
        else{
            oscillator.amplitude = random(0.5,1)
            oscillator.frequency = random(220, 880)
            oscillator.start()
            
            sender.setTitle("STOP", for: .normal)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        AudioKit.output = AKMixer(oscillator, oscillator)
        
        motionManager.startAccelerometerUpdates()
        motionManager.startDeviceMotionUpdates()

        
        try!AudioKit.start()
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)

        
    }
    
    @objc func update() {

        if let accelerometerData = motionManager.deviceMotion {
            print(accelerometerData)
        }
        
        if oscillator.isPlaying{
            let frequencyData = motionManager.deviceMotion?.attitude.roll
            oscillator.frequency = abs(frequencyData! * 3000)
        }

        }
        
    }

