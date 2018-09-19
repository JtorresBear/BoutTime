//
//  GameOverController.swift
//  BoutTime1
//
//  Created by Juan Torres on 9/19/18.
//  Copyright © 2018 Juan Torres. All rights reserved.
//

import UIKit

class GameOverController: UIViewController {
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = score
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
