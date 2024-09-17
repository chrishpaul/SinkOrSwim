//
//  QuizViewController.swift
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/11/24.
//

import UIKit

class QuizViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ResultsViewDelegate {
    
    

    

    @IBOutlet weak var viewRsultsButton: UIButton!
    @IBOutlet weak var mandarinLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var timedModeLabel: UILabel!
    @IBOutlet weak var timerSwitch: UISwitch!
    lazy var mandarinModel : MandarinModel = {
        return MandarinModel.sharedInstance();
    }()
    
    var timer : Timer?
    var wordindex : Int = 0
    var correct : Int = 0
    
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
    
    func didTapRestart() {
        resetView()
    }
    
    /*
    @objc func presentResultsVC() {
        let destinationVC = ResultsViewController()
        destinationVC.delegate = self
        
        destinationVC.modalPresentationStyle = .pageSheet
        present(destinationVC, animated: false)
    }
    */

    @IBOutlet weak var answerPicker: UIPickerView!
    
    func resetView(){
        countDown = Int(timeSlider.value)
        countdownLabel.text = String(countDown) + "s"
        resultLabel.isHidden = true
        
        self.submitButton.isHidden = true
        self.answerPicker.isHidden = true
        self.resultLabel.isHidden = true
        
        self.startButton.isHidden = false
        self.viewRsultsButton.isHidden = true
        self.mandarinLabel.isHidden = true
        self.answerPicker.isHidden = true
        self.timeSlider.isHidden = false
        self.timerSwitch.isHidden = false
        self.timedModeLabel.isHidden = false
        
        wordindex = 0
        correct = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        answerPicker.delegate = self
        answerPicker.dataSource = self
        resetView()
        
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
        //self.submitButton.isHidden = false
    }
    
    @objc func countdownTimer(){
        countDown -= 1
        var result = ""
        if countDown > 0 {
            result = String(countDown) + "s"
        }else{
            stopTimer()
            result = "Time's Up!"
            self.submitButton.isHidden = true
            self.answerPicker.isHidden = true
            self.resultLabel.isHidden = true
            viewRsultsButton.isHidden = false
        }
        self.countdownLabel.text =  result
        //self.resultLabel.isHidden = false
            
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? ResultsViewController{
            vc.delegate = self
            vc.correct = self.correct
            vc.total = testWords.count
        }
    }
    
    
    @IBOutlet weak var timeSlider: UISlider!
    @IBAction func timeChanged(_ sender: UISlider) {
        countDown = Int(sender.value)
        countdownLabel.text = String(countDown) + "s"
    }
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
            correct += 1
            print(correct)
            if self.wordindex == self.testWords.count {
                //result = result + "\nQuiz Complete."
                //print(result)
                result = "Quiz Complete! Good Job!"
                if self.timerSwitch.isOn{
                    stopTimer()
                }
                viewRsultsButton.isHidden = false
                
                //presentResultsVC()
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
    @IBOutlet weak var timeRemainLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBAction func startQuiz(_ sender: UIButton) {
        self.startButton.isHidden = true
        self.viewRsultsButton.isHidden = true
        self.mandarinLabel.isHidden = false
        self.answerPicker.isHidden = false
        self.timeSlider.isHidden = true
        self.timerSwitch.isHidden = true
        self.timedModeLabel.isHidden = true
        /*
        self.submitButton.isHidden = false
        */
        showNextWord()
        if self.timerSwitch.isOn{
            startTimer()
        }
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
    @IBAction func timerSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            self.timeSlider.isHidden = false
            self.countdownLabel.isHidden = false
            self.timeRemainLabel.isHidden = false
        }else{
            self.timeSlider.isHidden = true
            self.countdownLabel.isHidden = true
            self.timeRemainLabel.isHidden = true
        }
    }
    
}
