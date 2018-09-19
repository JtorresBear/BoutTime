//
//  ViewController.swift
//  BoutTime1
//
//  Created by Juan Torres on 9/17/18.
//  Copyright © 2018 Juan Torres. All rights reserved.
//

import UIKit

var score = " " 


class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nextRoundButton: UIButton!
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
    @IBOutlet weak var gameOverButton: UIButton!
    @IBOutlet weak var yourScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    
    
    
    
    
    
    var time = 60
    var timer = Timer()
    var game = Game()
    var round = 0
    
    
   
    
    @objc func countDownTimer()
    {
        time -= 1
        timeLabel.text = ("\(time)")
        if(time == 0)
        {
            endRound()
        }
        
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timeLabel.text = "60"
       displayEvents()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDownTimer), userInfo: nil, repeats: true)
        nextRoundButton.isHidden = true
        gameOverButton.isHidden = true
        showScoreAndButtons(isHidden: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayEvents()
    {
        firstEvent.text = game.gameEvents.listOfEvents[game.randomArrayForRound[0]].event
        secondEvent.text = game.gameEvents.listOfEvents[game.randomArrayForRound[1]].event
        thirdEvent.text = game.gameEvents.listOfEvents[game.randomArrayForRound[2]].event
        lastEvent.text = game.gameEvents.listOfEvents[game.randomArrayForRound[3]].event
    }
    
    @IBAction func changeEvents(_ sender: UIButton) {
        
        switch sender
        {
        case firstDownButton: switchFirst(game.randomArrayForRound[0], with: game.randomArrayForRound[1], at: 0, 1);
            firstDownButton.setImage(#imageLiteral(resourceName: "down_full_selected"), for: .highlighted)
        case firstUpButton: switchFirst(game.randomArrayForRound[0], with: game.randomArrayForRound[1], at: 0, 1);
        firstUpButton.setImage(#imageLiteral(resourceName: "up_half_selected"), for: .highlighted)
        case secondDownButton: switchFirst(game.randomArrayForRound[1], with: game.randomArrayForRound[2], at: 1, 2);
            secondDownButton.setImage(#imageLiteral(resourceName: "down_half_selected"), for: .highlighted)
        case secondUpButton: switchFirst(game.randomArrayForRound[1], with: game.randomArrayForRound[2], at: 1, 2);
            secondUpButton.setImage(#imageLiteral(resourceName: "up_half_selected"), for: .highlighted)
        case thirdDownButton: switchFirst(game.randomArrayForRound[2], with: game.randomArrayForRound[3], at: 2, 3);
            thirdDownButton.setImage(#imageLiteral(resourceName: "down_half_selected"), for: .highlighted   )
        case thirdUpButton : switchFirst(game.randomArrayForRound[2], with: game.randomArrayForRound[3], at: 2, 3);
            thirdUpButton.setImage(#imageLiteral(resourceName: "up_full_selected"), for: .highlighted)
        default:
            print("do Nothing")
        }
        
    }
    
    
    
    
    func switchFirst(_ label: Int, with secondLabel: Int, at index: Int, _ withIndex: Int)
    {
        game.randomArrayForRound[index] = secondLabel
        game.randomArrayForRound[withIndex] = label
        displayEvents()
    }
    
    func newRound()
    {
        game.newRound()
        time = 60
        timeLabel.text = "60"
        displayEvents()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDownTimer), userInfo: nil, repeats: true)
    }
    
    
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        endRound()
        
    }
    

    @IBAction func newRound(_ sender: UIButton) {
        newRound()
        nextRoundButton.isEnabled = false
        nextRoundButton.isHidden = true
        enableButton(isTrue: true)
        
    }
    
    
    func enableButton(isTrue: Bool)
    {
        firstDownButton.isEnabled = isTrue
        firstUpButton.isEnabled = isTrue
        secondDownButton.isEnabled = isTrue
        secondUpButton.isEnabled = isTrue
        thirdDownButton.isEnabled = isTrue
        thirdUpButton.isEnabled = isTrue
        
    }
    
    func endRound()
    {
        round += 1
        timer.invalidate()
        if(game.roundEnd())
        {
            nextRoundButton.setImage(#imageLiteral(resourceName: "next_round_success") ,for: .normal)
            nextRoundButton.isEnabled = true
            enableButton(isTrue: false)
        }
        else
        {
            nextRoundButton.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
            nextRoundButton.isEnabled = true
            enableButton(isTrue: false)
        }
        
        nextRoundButton.isHidden = false
        
        if(round >= game.numberOfRounds)
        {
            nextRoundButton.isHidden = true
            gameOverButton.isHidden = false
            
        }
        
        score = "\(game.score)/6"
    }
    
    func showScoreAndButtons(isHidden: Bool)
    {
        yourScoreLabel.isHidden = isHidden
        scoreLabel.isHidden = isHidden
        playAgainButton.isHidden = isHidden
        timeLabel.isHidden = !isHidden
        nextRoundButton.isHidden = !isHidden
        firstEvent.isHidden = !isHidden
        secondEvent.isHidden = !isHidden
        thirdEvent.isHidden = !isHidden
        lastEvent.isHidden = !isHidden
        firstDownButton.isHidden = !isHidden
        firstUpButton.isHidden = !isHidden
        secondDownButton.isHidden = !isHidden
        secondUpButton.isHidden = !isHidden
        thirdDownButton.isHidden = !isHidden
        thirdUpButton.isHidden = !isHidden
    }
    
    @IBAction func gameOver(_ sender: UIButton) {
        scoreLabel.text = "\(game.score)/6"
        
        showScoreAndButtons(isHidden: false)
        gameOverButton.isHidden = true
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        round = 0
        showScoreAndButtons(isHidden: true)
        newRound()
        nextRoundButton.isHidden = true
        enableButton(isTrue: true)
        game.score = 0
    }
    
    
    
}

































