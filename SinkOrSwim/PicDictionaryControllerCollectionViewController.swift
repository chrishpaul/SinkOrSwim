//
//  PicDictionaryControllerCollectionViewController.swift
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/11/24.
//

import UIKit

class PicDictionaryControllerCollectionViewController: UICollectionViewController {
    // Subclass of UICollectionViewController for Pictionary Dictionary view

    //MARK: Variables
    lazy var mandarinModel = {
        return MandarinModel.sharedInstance()
    }()
    
    private let reuseIdentifier = "CollectCell"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource Functions

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mandarinModel.numberOfWords()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell{
            
            // Lookup english word from row of collection cell
            let englishWord = mandarinModel.getEnglishWord(at: indexPath.row)
            
            // Set up view
            cell.englishLabel.text = englishWord
            cell.mandarinLabel.text = mandarinModel.getMandarinFor(englishWord)
            cell.pinyinLabel.text = mandarinModel.getPinyinFor(englishWord)
            cell.picture.image = mandarinModel.getPicFor(englishWord)
            return cell
        }else{      // Unexpected case
            fatalError("Could not dequeue cell")
        }
    }
}
