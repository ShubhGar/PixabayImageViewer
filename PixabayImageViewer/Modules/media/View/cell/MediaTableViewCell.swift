//
//  MediaTableViewCell.swift
//  PixabayImageViewer
//
//  Created by Shubham Garg on 27/09/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import UIKit
import SDWebImage
class MediaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var heightOfImage: NSLayoutConstraint!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    // set media name
    func set(name : String){
        self.userName.text = name
    }
    //Set image if available
    func set(imageUrl : String, aspectHeight: CGFloat){
        if let url = URL(string: imageUrl) {
            self.previewImageView.sd_setImage(with: url, completed: nil)
            heightOfImage.constant = aspectHeight
        }
        else{
           heightOfImage.constant = 0
        }
    }
    
}
