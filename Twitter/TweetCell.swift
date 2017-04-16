//
//  TweetCell.swift
//  Twitter
//
//  Created by Luis Rocha on 4/16/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var screennameLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            if let screenname = tweet.user?.screenname {
                screennameLabel.text = "@" + screenname
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
