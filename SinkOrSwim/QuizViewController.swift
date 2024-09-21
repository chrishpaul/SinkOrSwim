//
//  QuizViewController.swift
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/11/24.
//

import UIKit

class QuizViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ResultsViewDelegate {
    // View Controller for Quiz view
    
    //MARK: Outlets
    @IBOutlet weak var timedModeLabel: UILabel!
    @IBOutlet weak var timerSwitch: UISwitch!
    @IBOutlet weak var timeRemainLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var mandarinLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var answerPicker: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var viewRsultsButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    //MARK: Variables
    lazy var mandarinModel : MandarinModel = {
        return MandarinModel.sharedInstance();
    }()
    
    //Shuffled list of words for quiz
    lazy var testWords : NSArray = {
        if let testWords = self.mandarinModel.getShuffledWords() as NSArray?{
            return testWords
        }
        return NSArray.init()
    }()
    
    var timer : Timer?          //Timer object for timed mode
    var wordindex : Int = 0     //For tracking current word
    var correct : Int = 0       //Counter for number of correct words
    var countDown : Int = 45    //Number of seconds remaining for quiz
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerPicker.delegate = self
        answerPicker.dataSource = self
        setupView()
    }
    
    func setupView(){
        // Function to set variables and controls to initial value
        
        // Reset variables to initial values
        wordindex = 0
        correct = 0
        countDown = Int(timeSlider.value)
        
        // Show elements visible at quiz initialization
        self.startButton.isHidden = false
        self.timedModeLabel.isHidden = false
        self.timerSwitch.isHidden = false
        self.countdownLabel.text = String(countDown) + "s"
        if self.timerSwitch.isOn == true {
            self.timeSlider.isHidden = false
            self.countdownLabel.isHidden = false
        } else {
            self.timeSlider.isHidden = true
            self.countdownLabel.isHidden = true
        }

        // Hide elements not visible at quiz initialization
        self.mandarinLabel.isHidden = true
        self.view2.isHidden = true
    }
    
    //MARK: Functions for quiz flow control
    func showNextWord(){
        // Function that displays next word
        
        resultLabel.text = ""       // Clear results label
        
        // Gets and displays next word
        if let englishWord = self.testWords[wordindex] as? String{
            mandarinLabel.text = self.mandarinModel.getMandarinFor(englishWord)
        }
        wordindex += 1              // Increment word index
        
        submitButton.isHidden = false       //Show submit button
    }
    
    //MARK: UIPickerViewDelegate Fuctions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.mandarinModel.numberOfWords()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.mandarinModel.getEnglishWord(at: row)
    }
    
    //MARK: ResultsViewDelegate Function
    func didTapRestart() {
        setupView()         //Reset quiz
    }
    

    // MARK: Timer functions
    
    func startTimer () {
        guard timer == nil else {return}        // Check that a timer is not already running

        // Create a Timer object which runs countdownTimer function every 1 second
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer () {
        // Function to stop timer
        timer?.invalidate()
        timer = nil
    }
    
    @objc func countdownTimer(){
        //Function called by Timer instance that implements a countdown timer
        countDown -= 1
        
        var result : String = ""                    // Holds text for result label
        
        if countDown > 0 {                          // Time remaining
            result = String(countDown) + "s"        // Update string for countdown label
        }else{                                      // Time runs out
            stopTimer()
            result = "Time's Up!"
            
            // Hide and show elements at end of quiz
            self.submitButton.isHidden = true
            self.answerPicker.isHidden = true
            self.resultLabel.isHidden = true
            self.viewRsultsButton.isHidden = false
        }
        self.countdownLabel.text =  result          // Update text of countdownLabel
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ResultsViewController{
            // Setup variables for destination view controller
            vc.delegate = self
            vc.correct = self.correct
            vc.total = self.testWords.count
        }
    }
    
    //MARK: IBActions
    
    @IBAction func timerSwitchChanged(_ sender: UISwitch) {
        // Function that handles UI updates based on timer swiitch state
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
    
    @IBAction func timeChanged(_ sender: UISlider) {
        // Update countdown value and displayed value based on slider value
        countDown = Int(sender.value)
        countdownLabel.text = String(countDown) + "s"
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        // Functon to handle quiz answer submission
        
        var result = ""     // String to be used for resultLabel text
        
        // Look up the Mandarin word for the selected answer from UIPicker
        let index = self.answerPicker.selectedRow(inComponent: 0)
        let englishWord = self.mandarinModel.getEnglishWord(at: index)
        let answer = self.mandarinModel.getMandarinFor(englishWord)
        
        // Compare the selected word to the correct answer
        if answer == self.mandarinLabel.text{               // Correct answer submitted
            self.submitButton.isHidden = true               // Hide submit button
            result = "Correct answer. Good Job!"            // Set text for correct answer
            correct += 1                                    // Increment correct answer counter
            if self.wordindex == self.testWords.count {     // End of list reached
                result = "Quiz Complete! Good Job!"
                if self.timerSwitch.isOn{                   // Handle timed mode
                    stopTimer()
                }
                viewRsultsButton.isHidden = false           // Show viewResults button at the end of the quiz
            }else{
                nextButton.isHidden = false                 // Show button to move to Next question button
            }
        }else{                                              // Incorrect answer submitted
            result = "Wrong answer. Try again."
        }
        self.resultLabel.text = result                      // Display outcome of answer submission
        self.resultLabel.isHidden = false
    }

    @IBAction func startQuiz(_ sender: UIButton) {
        // Function to handle the start of the quiz
        
        // Hide elements not visible in quiz mode
        self.startButton.isHidden = true
        self.timeSlider.isHidden = true
        self.timerSwitch.isHidden = true
        self.timedModeLabel.isHidden = true
        self.viewRsultsButton.isHidden = true
        
        // Show elements required for start of quiz
        self.mandarinLabel.isHidden = false
        self.view2.isHidden = false
        self.answerPicker.isHidden = false
        
        showNextWord()
        
        if self.timerSwitch.isOn{           // Check if timed mode is activated
            startTimer()                    // and start timer
        }
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        // Function that handles nextQuestion button being clicked
        nextButton.isHidden = true
        showNextWord()
    }
}
