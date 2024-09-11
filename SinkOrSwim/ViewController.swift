//
//  ViewController.swift
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mandarinLabel: UILabel!
    @IBOutlet weak var pinyinLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    
    @IBOutlet weak var wordNavigation: UIStepper!
    var englishWord = "English"
   
    lazy var mandarinModel: MandarinModel = {
        return MandarinModel.sharedInstance()
    }()
    
    /*lazy var wordIndex: Int = {
        return MandarinModel.sharedInstance().getIndexOfWord(englishWord)
    }()*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setWords()
        wordNavigation.maximumValue = Double(self.mandarinModel.numberOfWords() - 1)
        wordNavigation.value = Double(self.mandarinModel.getIndexOfWord(englishWord))
    }
    
    func setWords() {
        englishLabel.text = englishWord
        mandarinLabel.text = self.mandarinModel.getMandarinForEnglish(englishWord)
        pinyinLabel.text = self.mandarinModel.getPinyinForEnglish(englishWord)
    }

    @IBAction func switchChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            mandarinLabel.isHidden = false
            englishLabel.isHidden = false
            pinyinLabel.isHidden = false
        case 1:
            mandarinLabel.isHidden = false
            englishLabel.isHidden = true
            pinyinLabel.isHidden = true
        case 2:
            mandarinLabel.isHidden = true
            englishLabel.isHidden = true
            pinyinLabel.isHidden = false
        case 3:
            mandarinLabel.isHidden = true
            englishLabel.isHidden = false
            pinyinLabel.isHidden = true
        default:
            mandarinLabel.isHidden = false
            englishLabel.isHidden = false
            pinyinLabel.isHidden = false
        }
    }
    
    @IBAction func changeWord(_ sender: UIStepper) {
        let index = Int(sender.value)
        englishWord = self.mandarinModel.getEnglishWord(at: index)
        setWords()
    }
}

