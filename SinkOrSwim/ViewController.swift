//
//  ViewController.swift
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/11/24.
//

import UIKit

class ViewController: UIViewController {
    // View Controller for Word Review view
    
    // MARK: Outlets
    @IBOutlet weak var mandarinLabel: UILabel!
    @IBOutlet weak var pinyinLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var wordNavigation: UIStepper!
    
    // MARK: Variables
    var englishWord = "English"
   
    lazy var mandarinModel: MandarinModel = {
        return MandarinModel.sharedInstance()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setWords()  //Set initial values to display
        
        // Parameters for UIStepper
        wordNavigation.maximumValue = Double(self.mandarinModel.numberOfWords() - 1)
        wordNavigation.value = Double(self.mandarinModel.getIndexOfWord(englishWord))
    }
    
    func setWords() {
        // Function to setup view
        englishLabel.text = englishWord
        mandarinLabel.text = self.mandarinModel.getMandarinForEnglish(englishWord)
        pinyinLabel.text = self.mandarinModel.getPinyinForEnglish(englishWord)
        self.imageView.image = self.mandarinModel.getPicForEnglishWord(englishWord)
    }

    @IBAction func switchChanged(_ sender: UISegmentedControl) {
        // Function that handles segmented control selection
        switch sender.selectedSegmentIndex{
        case 0:                                 //All languages
            mandarinLabel.isHidden = false
            englishLabel.isHidden = false
            pinyinLabel.isHidden = false
        case 1:                                 //Mandarin only
            mandarinLabel.isHidden = false
            englishLabel.isHidden = true
            pinyinLabel.isHidden = true
        case 2:                                 //Pinyin only
            mandarinLabel.isHidden = true
            englishLabel.isHidden = true
            pinyinLabel.isHidden = false
        case 3:                                 //English only
            mandarinLabel.isHidden = true
            englishLabel.isHidden = false
            pinyinLabel.isHidden = true
        default:                                //Default to all
            mandarinLabel.isHidden = false
            englishLabel.isHidden = false
            pinyinLabel.isHidden = false
        }
    }
    
    @IBAction func changeWord(_ sender: UIStepper) {
        // Function to change word selection based on stepper
        let index = Int(sender.value)
        englishWord = self.mandarinModel.getEnglishWord(at: index)
        setWords()      //Call to update view
    }
}

