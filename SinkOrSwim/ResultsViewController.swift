//
//  ResultsViewController.swift
//  SinkOrSwim
//

import UIKit

protocol ResultsViewDelegate {
    func didTapRestart()
}
class ResultsViewController: UIViewController {
    
    
    var delegate : ResultsViewDelegate?
    var correct : Int = 0
    var total : Int = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score: " + String(self.correct) + " out of " + String(total)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func restartSelected(_ sender: Any) {
        delegate?.didTapRestart()
        dismiss(animated: true)
    }
    
    @IBAction func okSelected(_ sender: Any) {
        //delegate?.didTap(restart: false)
        dismiss(animated: true)
    }
}
