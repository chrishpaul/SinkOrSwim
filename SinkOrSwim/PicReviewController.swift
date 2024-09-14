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
    
    lazy var mandarinModel = {
        return MandarinModel.sharedInstance()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView1.image = self.mandarinModel.getPictureFor(0)
        imageView2.image = self.mandarinModel.getPictureFor(1)
        imageView3.image = self.mandarinModel.getPictureFor(2)
        imageView4.image = self.mandarinModel.getPictureFor(3)
        imageView5.image = self.mandarinModel.getPictureFor(4)
        
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
