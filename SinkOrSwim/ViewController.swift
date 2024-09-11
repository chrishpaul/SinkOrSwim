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


}

