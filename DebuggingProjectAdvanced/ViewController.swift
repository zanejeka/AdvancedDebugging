//
//  ViewController.swift
//  DebuggingProjectAdvanced
//
//  Created by Thinkful on 12/12/2014.
//  Copyright (c) 2014 Thinkful. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    let gameModel = GameModel()
    
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessFeedback: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var instructionsLabel2: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    
    var tries = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        guessTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func checkGuess() {
        if let guessText = guessTextField.text {
            let guess = Int(guessText)
            if let guessUnwrapped = guess {
                tries++
                //get tuple back from gameModel
                let (guessIsCorrect,guessIsHigher) = gameModel.makeGuess(guessUnwrapped)
                if (guessIsCorrect) {
                    guessFeedback.text = "\(guessUnwrapped)! Well done! You guessed it in \(tries) tries!"
                    //hide the game, and display play again button
                    playAgainButton.hidden = false
                    instructionsLabel.hidden = true
                    instructionsLabel2.hidden = true
                    guessTextField.hidden = true
                    guessButton.hidden = true
                } else if (guessIsHigher) { //guess was higher, so the player should guess lower
                    guessFeedback.text = "Try \(tries) - \(guessUnwrapped): Bad luck! Lower!"
                } else {                    //guess was lower, so the player should guess higher
                    guessFeedback.text = "Try \(tries) - \(guessUnwrapped): Bad luck! Higher!"
                }
            }
            guessTextField.text = ""
        }
    }
    
    //MARK: UITextFieldDelegate functions
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkGuess()
        return true
    }
    //MARK: IBActions
    @IBAction func makeGuess(sender: AnyObject) {
        guessTextField.resignFirstResponder()
        checkGuess()
    }
    @IBAction func playAgain(sender: AnyObject) {
        //reset the game
        gameModel.resetComputerRandomNumber()
        guessFeedback.text = ""
        tries = 0
        //hide the play again button, display the game
        playAgainButton.hidden = true
        guessTextField.hidden = false
        guessButton.hidden = false
        instructionsLabel.hidden = false
        instructionsLabel2.hidden = false
    }
}

