//
//  ViewController.swift
//  BoutTime1
//
//  Created by Juan Torres on 9/17/18.
//  Copyright © 2018 Juan Torres. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    
    @IBOutlet weak var firstEvent: UILabel!
    @IBOutlet weak var secondEvent: UILabel!
    @IBOutlet weak var thirdEvent: UILabel!
    @IBOutlet weak var lastEvent: UILabel!
    @IBOutlet weak var firstDownButton: UIButton!
    @IBOutlet weak var firstUpButton: UIButton!
    @IBOutlet weak var secondDownButton: UIButton!
    @IBOutlet weak var secondUpButton: UIButton!
    @IBOutlet weak var thirdDownButton: UIButton!
    @IBOutlet weak var thirdUpButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    var time = 60
    var timer = Timer()
    
   
    
    @objc func countDownTimer() throws
    {
        time -= 1
        timeLabel.text = ("\(time)")
        if(time == 50)
        {
            timer.invalidate()
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timeLabel.text = "60"
       
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDownTimer), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

