//
//  QuizViewController.swift
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/11/24.
//

import UIKit

class QuizViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var mandarinLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    lazy var mandarinModel : MandarinModel = {
        return MandarinModel.sharedInstance();
    }()
    
    lazy var testWords : NSArray = {
        if let testWords = self.mandarinModel.getShuffledWords() as NSArray?{
            //print(testWords)
            return testWords
        }
        return NSArray.init()

        //var words = self.mandarinModel.getShuffledWords();
        //return words;
    }()
    
    var countDown : Int = 10

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.mandarinModel.numberOfWords()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.mandarinModel.getEnglishWord(at: row)
    }
    

    @IBOutlet weak var answerPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerPicker.delegate = self
        answerPicker.dataSource = self
        countdownLabel.text = "Time Remaining: " + String(countDown) + " s"
        resultLabel.isHidden = true
        
        if let englishWord = self.testWords[0] as? String{
            mandarinLabel.text = self.mandarinModel.getMandarinForEnglish(englishWord)
        }
        print(self.testWords)
        
        /*
        var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeLabel), userInfo: nil, repeats: true)
         */
        // Do any additional setup after loading the view.
        //self.testWords;
    }
    
    @objc func countdownTimer(){
        countDown -= 1
        var result = ""
        if countDown > 0 {
            result = "Time Remaining: " + String(countDown) + " s"
        }else if countDown == 0 {
            result = "Time's Up!"
            self.submitButton.isHidden = true
            self.answerPicker.isHidden = true
            self.resultLabel.isHidden = true
        }else{
            
        }
        self.countdownLabel.text =  result
        //self.resultLabel.isHidden = false
            
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func submitClicked(_ sender: UIButton) {
        let index = self.answerPicker.selectedRow(inComponent: 0)
        let englishWord = self.mandarinModel.getEnglishWord(at: index)
        print(englishWord)
        //let english =
        let answer = self.mandarinModel.getMandarinForEnglish(englishWord)
        print(answer)
        var result = ""
        if answer == self.mandarinLabel.text{
            countDown = 0
            result = "Correct answer. Good Job!"
            //self.resultLabel.text = "Correct answer. Good Job!"
            //self.resultLabel.isHidden = false
            //print("Correct answer. Good Job!")
        }else{
            result = "Wrong answer. Try again."
            //self.resultLabel.text = "Wrong answer. Try again."
            //print("Wrong answer. Try again.")
        }
        self.resultLabel.text = result
        self.resultLabel.isHidden = false
    }
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBAction func startQuiz(_ sender: UIButton) {
        self.startButton.isHidden = true
        self.mandarinLabel.isHidden = false
        self.answerPicker.isHidden = false
        self.submitButton.isHidden = false
        
        
        var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownTimer), userInfo: nil, repeats: true)
        
    }
    
}
