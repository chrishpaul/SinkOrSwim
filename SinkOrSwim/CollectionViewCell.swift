//
//  CollectionViewCell.swift
//  SinkOrSwim
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    //CollectionViewCell subclass for Picture Dictionary
    
    @IBOutlet weak var picture: UIImageView!        //Image for word
    @IBOutlet weak var mandarinLabel: UILabel!      //Mandarin translation
    @IBOutlet weak var pinyinLabel: UILabel!        //Pinyin form
    @IBOutlet weak var englishLabel: UILabel!       //English translation
}
