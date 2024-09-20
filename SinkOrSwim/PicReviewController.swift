//
//  PicReviewController.swift
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/13/24.
//

import UIKit

class PicReviewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!

    lazy var mandarinModel = {
        return MandarinModel.sharedInstance()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for word in (self.mandarinModel.getEnglishWords() as NSArray as! [String]) {
            addItem(englishWord: word)
        }
        
        self.scrollView.delegate = self
        self.scrollView.maximumZoomScale = 2.0
        self.scrollView.minimumZoomScale = 0.1


        // Do any additional setup after loading the view.
    }
    
    func addItem(englishWord : String){
        let picture = UIImageView.init(image: self.mandarinModel.getPicForEnglishWord(englishWord))
        picture.contentMode = .scaleAspectFit
        let label = UILabel()
        label.text = self.mandarinModel.getMandarinForEnglish(englishWord)
        label.textAlignment = .center
        label.font = label.font.withSize(36)
        stackView.addArrangedSubview(picture)
        stackView.addArrangedSubview(label)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.stackView
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
