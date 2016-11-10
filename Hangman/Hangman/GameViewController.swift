//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var submitGuess: UIButton!
    @IBOutlet weak var numWrong: UILabel!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var displayChars: UILabel!
    @IBOutlet weak var wrongGuesses: UILabel!
    @IBOutlet weak var guessField: UITextField!
    var word = [Character]()
    var displayWord = [Character]()
    var numberWrong:Int = 0
    
    
    func begin() {
        // Do any additional setup after loading the view.
        numWrong.text = String(self.numberWrong)
        wrongGuesses.text = ""
        
        let hangmanPhrases = HangmanPhrases()
        let phrase:String! = hangmanPhrases.getRandomPhrase()
        print(phrase)
        
        word.removeAll()
        displayWord.removeAll()
        numberWrong = 0
        numWrong.text = String(numberWrong)
        for c in phrase.characters {
            self.word.append(c)
        }
        displayChars.text = ""
        for c in phrase.characters {
            if c == " " {
                displayWord.append(" ")
                displayChars.text?.append(" ")
            } else {
                displayWord.append("_")
                displayChars.text?.append("_")
            }
        }
        hangmanImage.image = UIImage(named: "hangman1.gif")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        begin()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(_ sender: Any) {
        var guess = guessField.text!
        if (wrongGuesses.text?.contains(guess.uppercased()))! {
            let alert = UIAlertController(title: "", message:"Already guessed letter!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}
        } else {
            guessField.text = ""
            if (guess.characters.count == 1) {
                let guessChar = Character(guess.uppercased())
                if self.word.contains(guessChar) {
                    for index in 0...(word.count - 1) {
                        if word[index] == guessChar {
                            displayWord[index] = guessChar
                        }
                    }
                    displayChars.text = ""
                    for c in displayWord {
                        displayChars.text?.append(c)
                    }
                } else {
                    self.numberWrong += 1
                    numWrong.text = String(self.numberWrong)
                    wrongGuesses.text! += String(guessChar) + " "
                    let hangIndex = self.numberWrong + 1
                    let hangString = "hangman" + String(hangIndex) + ".gif"
                    hangmanImage.image = UIImage(named: hangString)
                    
                    
                }
            } else {
                let alert = UIAlertController(title: "", message:"Guess only one letter", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
            }
            if (self.numberWrong == 6) {
                let alert = UIAlertController(title: "", message:"You lose!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Start New Game", style: .default) { _ in
                    self.begin()
                })
                self.present(alert, animated: true){}
            }
            else if (!displayWord.contains("_")) {
                let alert = UIAlertController(title: "", message:"You Win!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Start New Game", style: .default) { _ in
                    self.begin()
                })
                self.present(alert, animated: true){}
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
