//
//  ViewController.swift
//  BoutTime1
//
//  Created by Juan Torres on 9/17/18.
//  Copyright © 2018 Juan Torres. All rights reserved.
//

import UIKit
import AVFoundation

var score = " " 


class ViewController: UIViewController {
    // Just a bunch of IBOutlets!!
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
    @IBOutlet weak var shakeLabel: UILabel!
    
    //creating for audio purposes. don't forget to import AVFoundation
    var player: AVAudioPlayer?
    
    
    
    //Setting up some variables for the ViewController to keep
    var time = 60
    var timer = Timer()
    var game = Game()
    var round = 0
    // helps so that the shake is registered but nothing happens
    var isShook = false
    
    
   
    //this function makes the timer go down and displays it.
    //it also stops the game if the counter reaches 0.
    @objc func countDownTimer()
    {
        time -= 1
        timeLabel.text = ("\(time)")
        if(time == 0)
        {
            endRound()
            isShook = true
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timeLabel.text = "60"
        displayEvents()
        //Starts the timer when the game starts
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDownTimer), userInfo: nil, repeats: true)
        nextRoundButton.isHidden = true
        nextRoundButton.isEnabled = false
        gameOverButton.isHidden = true
        showScoreAndButtons(isHidden: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Displays Events using hardCoded indexes because they will always hold the same place unless changed.
    func displayEvents()
    {
        firstEvent.text = game.gameEvents.listOfEvents[game.randomArrayForRound[0]].event
        secondEvent.text = game.gameEvents.listOfEvents[game.randomArrayForRound[1]].event
        thirdEvent.text = game.gameEvents.listOfEvents[game.randomArrayForRound[2]].event
        lastEvent.text = game.gameEvents.listOfEvents[game.randomArrayForRound[3]].event
    }
    
    
    //Switches the labels to read differently. although this function doesn't change the display
    //the function that changes the display is called inside this function
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
    
    
    
    //this function changes the values of the indexes using its because they are given ints
    //the ints given are for the events array in the game. and the other indexes are for
    // the random array to hold the new values.
    //then the displayevents fuction is called to repoppulate the labels
    func switchFirst(_ label: Int, with secondLabel: Int, at index: Int, _ withIndex: Int)
    {
        game.randomArrayForRound[index] = secondLabel
        game.randomArrayForRound[withIndex] = label
        displayEvents()
    }
    //just initiates a new round. resets values and calls functions that need to be called
    func newRound()
    {
        game.newRound()
        time = 60
        timeLabel.text = "60"
        displayEvents()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDownTimer), userInfo: nil, repeats: true)
    }
    
    
    // checks if the device has been shaken, and then ends the round by calling the endRound() function
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if(!isShook)
        {
            endRound()
            isShook = true
        }
        
    }
    

    //starts a a button that starts a new round and changes values
    @IBAction func newRound(_ sender: UIButton) {
        newRound()
        nextRoundButton.isEnabled = false
        nextRoundButton.isHidden = true
        enableButton(isTrue: true)
        shakeLabel.isHidden = false
        isShook = false
    }
    
    // disables or enables buttons so they can't switch values when the round is over
    func enableButton(isTrue: Bool)
    {
        firstDownButton.isEnabled = isTrue
        firstUpButton.isEnabled = isTrue
        secondDownButton.isEnabled = isTrue
        secondUpButton.isEnabled = isTrue
        thirdDownButton.isEnabled = isTrue
        thirdUpButton.isEnabled = isTrue
        
    }
    //ends the round. also calls on game functions to figure out if the round is correct or incorrect
    //changes score sets the button images as needed. also plays a sound as needed.
    func endRound()
    {
        shakeLabel.isHidden = true
        round += 1
        timer.invalidate()
        if(game.roundEnd())
        {
            nextRoundButton.setImage(#imageLiteral(resourceName: "next_round_success") ,for: .normal)
            nextRoundButton.isEnabled = true
            enableButton(isTrue: false)
            playSound(if: true)
            
        }
        else
        {
            nextRoundButton.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
            nextRoundButton.isEnabled = true
            enableButton(isTrue: false)
            playSound(if: false)
        }
        
        nextRoundButton.isHidden = false
        
        if(round >= game.numberOfRounds)
        {
            nextRoundButton.isHidden = true
            gameOverButton.isHidden = false
            
        }
        
        score = "\(game.score)/6"
    }
    
    //hides or shows labels and buttons
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
    
    //shows the game is over. then proceeds to end the game and show what looks like a new screen
    @IBAction func gameOver(_ sender: UIButton) {
        scoreLabel.text = "\(game.score)/6"
        
        showScoreAndButtons(isHidden: false)
        gameOverButton.isHidden = true
    }
    //starts a new game and resets everything that needs to be.
    @IBAction func newGame(_ sender: UIButton) {
        round = 0
        showScoreAndButtons(isHidden: true)
        newRound()
        nextRoundButton.isHidden = true
        enableButton(isTrue: true)
        game.score = 0
        shakeLabel.isHidden = false
        isShook = false
    }
    
    //plays a sound. the sound is loaded depending on whether the round is correct or not.
    func playSound(if CorrectOrFalse: Bool)
    {
        var mainUrl: URL?
        
        if(!CorrectOrFalse)
        {
            guard let url = Bundle.main.url(forResource: "IncorrectBuzz", withExtension: "wav")
                else
                {
                    print("url not found")
                    return
                }
            mainUrl = url
        }
        else
        {
            guard let url = Bundle.main.url(forResource: "CorrectDing", withExtension: "wav")
                else
            {
                print("url not found")
                return
            }
            mainUrl = url
        }
            
        do {
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)), mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: mainUrl!, fileTypeHint: AVFileType.mp3.rawValue)
            
            player!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
            
        }
    
    
}


































// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
