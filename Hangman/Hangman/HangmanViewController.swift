//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var game: GameControl?
    @IBOutlet weak var hangman: UIImageView!
    @IBOutlet weak var wordView: UILabel!
    @IBOutlet weak var guesses: UILabel!
    @IBOutlet weak var letterPicker: UIPickerView!
    @IBOutlet weak var guessBtn: UIButton!
    var letters: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.letterPicker.dataSource = self
        self.letterPicker.delegate = self
        
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        setGame(phrase: phrase)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return letters.characters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(letters[letters.index(letters.startIndex, offsetBy: row)])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let letter = self.letters.characters.index(self.letters.startIndex, offsetBy: row)
        guessBtn.setTitle("Guess " + String(self.letters[letter]), for: .normal)
    }
    
    func setGame(phrase: String) {
        game = GameControl(phrase: phrase)
        wordView.text = game!.getBlank()
        updateHangman(man: 1)
    }
    
    @IBAction func newGame(_ sender: Any) {
        self.viewDidLoad()
    }
    
    @IBAction func guessPressed(_ sender: Any) {
        let btnText = self.guessBtn.title(for: .normal)
        let index = btnText!.characters.index(btnText!.startIndex, offsetBy: 6)
        let guess = btnText![index]
        let man: Int = game!.getManState(guess: guess)
        updateHangman(man: man)
    }
    
    func updateHangman(man: Int) {
        updateBlankState();
        updateGuesses();
        if man == -1 {
            hangman.image = UIImage(named: "hangman7")
            makeAlert(title: "The man is hung!", message: "Game over.", btnTitle: "New Game")
        } else {
            let hangImg = "hangman" + String(describing: man)
            hangman.image = UIImage(named: hangImg)
        }
    }
    
    func updateBlankState() {
        let newBlanks = game!.getBlankState()
        wordView.text = newBlanks
        if !newBlanks.contains("_") {
            makeAlert(title: "You won!", message: "Play again?", btnTitle: "New Game")
        }
    }
    
    func updateGuesses() {
        let newGuesses = game!.getGuesses()
        guesses.text = "Incorrect guesses: " + newGuesses
    }
    
    func makeAlert(title: String, message: String, btnTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: btnTitle, style: UIAlertActionStyle.default, handler: {action in self.viewDidLoad()}))
        
        self.present(alertController, animated: true, completion: nil)
    }

}
