//
//  PicReviewController.swift
//  SinkOrSwim
//

import UIKit

class PicReviewController: UIViewController, UIScrollViewDelegate {
    // Subclass of UIViewController for scrollable, zoomable Picture Review view

    // MARK: Outlets
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!

    // MARK: Variables
    lazy var mandarinModel = {
        return MandarinModel.sharedInstance()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call addItem to add all words to a stackview
        for word in (self.mandarinModel.getEnglishWords() as NSArray as! [String]) {
            addItem(englishWord: word)
        }
        
        // Setup for scrollView
        self.scrollView.delegate = self
        self.scrollView.maximumZoomScale = 2.0
        self.scrollView.minimumZoomScale = 0.1


        // Do any additional setup after loading the view.
    }
    
    func addItem(englishWord : String){
        // Function to add an image and corresponding Mandarin word to a stackView
        
        // Fetch and configure image
        let picture = UIImageView.init(image: self.mandarinModel.getPicFor(englishWord))
        picture.contentMode = .scaleAspectFit
        
        // Configure label
        let label = UILabel()
        label.text = self.mandarinModel.getMandarinFor(englishWord)
        label.textAlignment = .center
        label.font = label.font.withSize(36)
        
        // Add items to stackview
        stackView.addArrangedSubview(picture)
        stackView.addArrangedSubview(label)
    }
    
    // MARK: UIScrollViewDelegate Function
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.stackView
    }
}
