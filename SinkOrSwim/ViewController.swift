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
    
    var englishWord = "English"
    var mandarinWord = "Mandarin"
   
    lazy var mandarinModel: MandarinModel = {
        return MandarinModel.sharedInstance()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mandarinLabel.text = mandarinWord
        englishLabel.text = englishWord
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
    
}

