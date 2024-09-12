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
    
    var timer : Timer?
    var wordindex : Int = 0
    
    lazy var testWords : NSArray = {
        if let testWords = self.mandarinModel.getShuffledWords() as NSArray?{
            //print(testWords)
            return testWords
        }
        return NSArray.init()

        //var words = self.mandarinModel.getShuffledWords();
        //return words;
    }()
    
    var countDown : Int = 45

    
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
        
        //showNextWord()
        /*
        if let englishWord = self.testWords[0] as? String{
            mandarinLabel.text = self.mandarinModel.getMandarinForEnglish(englishWord)
        }
        */
        print(self.testWords)
        
        /*
        var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeLabel), userInfo: nil, repeats: true)
         */
        // Do any additional setup after loading the view.
        //self.testWords;
    }
    
    func showNextWord(){
        resultLabel.text = ""
        if let englishWord = self.testWords[wordindex] as? String{
            mandarinLabel.text = self.mandarinModel.getMandarinForEnglish(englishWord)
        }
        wordindex += 1
        //mandarinLabel.isHidden = false
        //answerPicker.isHidden = false
        submitButton.isHidden = false
        self.submitButton.isHidden = false
    }
    
    @objc func countdownTimer(){
        countDown -= 1
        var result = ""
        if countDown > 0 {
            result = "Time Remaining: " + String(countDown) + " s"
        }else{
            stopTimer()
            result = "Time's Up!"
            self.submitButton.isHidden = true
            self.answerPicker.isHidden = true
            self.resultLabel.isHidden = true
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
            self.submitButton.isHidden = true
            result = "Correct answer. Good Job!"
            if self.wordindex == self.testWords.count {
                //result = result + "\nQuiz Complete."
                //print(result)
                stopTimer()
            }else{
                nextButton.isHidden = false
            }
        }else{
            result = "Wrong answer. Try again."
        }
        self.resultLabel.text = result
        self.resultLabel.isHidden = false
    }
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBAction func startQuiz(_ sender: UIButton) {
        self.startButton.isHidden = true
        self.mandarinLabel.isHidden = false
        self.answerPicker.isHidden = false
        /*
        self.submitButton.isHidden = false
        */
        showNextWord()
        startTimer()
    }
    @IBAction func nextQuestion(_ sender: UIButton) {
        nextButton.isHidden = true
        showNextWord()
    }
    func startTimer () {
        guard timer == nil else {return}

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer () {
        timer?.invalidate()
        timer = nil
    }
}
