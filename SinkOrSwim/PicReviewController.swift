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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView1.image = UIImage(named: "weekend")
        imageView2.image = UIImage(named: "dance")
        imageView3.image = UIImage(named: "weekend")
        imageView4.image = UIImage(named: "weekend")
        imageView5.image = UIImage(named: "weekend")
        
        self.scrollView.delegate = self
        self.scrollView.maximumZoomScale = 2.0

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
