//
//  TweetCell.swift
//  Twitter
//
//  Created by Luis Rocha on 4/16/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetedImageView: UIImageView!
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            retweetedLabel.isHidden = !tweet.retweeted
            retweetedImageView.isHidden = !tweet.retweeted
            if let imageUrl = tweet.user?.profileUrl {
                profileImageView.setImageWith(imageUrl)
            }
            if let name = tweet.user?.name {
                nameLabel.text = name
            }
            if let screenname = tweet.user?.screenname {
                screennameLabel.text = "@" + screenname
            }
            if let timestamp = tweet.timestamp {
                let hours = Calendar.current.dateComponents([.hour], from: timestamp, to: Date()).hour ?? 0
                if hours > 0 {
                    timestampLabel.text = String("\(hours)h")
                } else {
                    let minutes = Calendar.current.dateComponents([.minute], from: timestamp, to: Date()).minute ?? 0
                    timestampLabel.text = String("\(minutes)min")
                }
            }
            messageLabel.text = tweet.text
            replyCountLabel.text = String("\(tweet.retweetCount)")
            retweetCountLabel.text = String("\(tweet.retweetCount)")
            favoritesCountLabel.text = String("\(tweet.favoritesCount)")
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
