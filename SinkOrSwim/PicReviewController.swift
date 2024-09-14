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
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    
    @IBOutlet weak var word1Label: UILabel!
    @IBOutlet weak var word2Label: UILabel!
    @IBOutlet weak var word3Label: UILabel!
    @IBOutlet weak var word4Label: UILabel!
    @IBOutlet weak var word5Label: UILabel!
    lazy var mandarinModel = {
        return MandarinModel.sharedInstance()
    }()
    
    
    lazy private var imageView6: UIImageView! = {
        var imageView = UIImageView.init(image: self.mandarinModel.getPictureFor(0))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var wordCount = self.mandarinModel.numberOfWords()
        
        for word in (self.mandarinModel.getEnglishWords() as NSArray as! [String]) {
            addItem(englishWord: word)
        }
        
        /*if let words = self.mandarinModel.getEnglishWords() as NSArray?{
            if let word in words as String?
            for word in words{
                addItem(englishWord: word)
            }
        }
        
        if let wordList = self.mandarinModel.getEnglishWords() as?
        for englishWord in self.mandarinModel.getEnglishWords() as! String{
            addItem(englishWord: englishWord)

        }*/
        
        /*setPicAndWordForIndex(index: 0, label: word1Label, picture: imageView1)
        setPicAndWordForIndex(index: 1, label: word2Label, picture: imageView2)
        setPicAndWordForIndex(index: 2, label: word3Label, picture: imageView3)
        setPicAndWordForIndex(index: 3, label: word4Label, picture: imageView4)
        setPicAndWordForIndex(index: 4, label: word5Label, picture: imageView5)*/
        
        //stackView.addArrangedSubview(imageView6)
        /*
        imageView1.image = self.mandarinModel.getPictureFor(0)
        word1Label.text = self.mandarinModel.getEnglishWord(at: 0)
        imageView2.image = self.mandarinModel.getPictureFor(1)
        word2Label.text = self.mandarinModel.getEnglishWord(at: 1)
        imageView3.image = self.mandarinModel.getPictureFor(2)
        word3Label.text = self.mandarinModel.getEnglishWord(at: 2)
        imageView4.image = self.mandarinModel.getPictureFor(3)
        word4Label.text = self.mandarinModel.getEnglishWord(at: 3)
        imageView5.image = self.mandarinModel.getPictureFor(4)
        word5Label.text = self.mandarinModel.getEnglishWord(at: 4)
        */
        
        /*if let image = self.imageView6?{
                
        }*/
        //self.stackView.addSubview(imageView6)
        
        /*
        imageView1.image = UIImage(named: "weekend")
        imageView2.image = UIImage(named: "dance")
        imageView3.image = UIImage(named: "play ball")
        imageView4.image = UIImage(named: "sing")
        imageView5.image = UIImage(named: "movies")
        */
        
        self.scrollView.delegate = self
        self.scrollView.maximumZoomScale = 2.0
        self.scrollView.minimumZoomScale = 0.1


        // Do any additional setup after loading the view.
    }
    
    func addItem(englishWord : String){
        var picture = UIImageView.init(image: self.mandarinModel.getPicForEnglishWord(englishWord))
        picture.contentMode = .scaleAspectFit
        picture.heightAnchor.constraint(equalToConstant: 400).isActive = true
        var label = UILabel()
        label.text = self.mandarinModel.getMandarinForEnglish(englishWord)
        label.textAlignment = .center
        label.font = label.font.withSize(36)
        stackView.addArrangedSubview(picture)
        stackView.addArrangedSubview(label)
    }
    
    func setPicAndWordForIndex(index : Int, label : UILabel, picture : UIImageView){
        var englishWord = self.mandarinModel.getEnglishWord(at: index)
        label.text = self.mandarinModel.getMandarinForEnglish(englishWord)
        picture.image =  self.mandarinModel.getPicForEnglishWord(englishWord)
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
