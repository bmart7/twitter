//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Brian Martin on 10/14/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favorited:Bool = false
    var retweeted:Bool = false
    var tweetId:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        if (!retweeted){
            TwitterAPICaller.client?.retweetTweet(tweetId: tweetId, success: {
                self.setRetweet(isRetweeted: true)
            }, failure: { (Error) in
                print("Retweet Failed \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unretweetTweet(tweetId: tweetId, success: {
                self.setRetweet(isRetweeted: false)
            }, failure: { (Error) in
                print("Unretweet Failed \(Error)")
            })
        }
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        if (!favorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: true)
            }, failure: { (Error) in
                print("Favorite Failed \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: false)
            }, failure: { (Error) in
                print("Unfavorite Failed \(Error)")
            })
        }
    }
    
    func setFavorite(isFavorited: Bool) {
        self.favorited = isFavorited
        let image = isFavorited ? "favor-icon-red" : "favor-icon"
        favoriteButton.setImage(UIImage(named:image), for: UIControl.State.normal)
    }
    
    func setRetweet(isRetweeted: Bool) {
        self.retweeted = isRetweeted
        let image = isRetweeted ? "retweet-icon-green" : "retweet-icon"
        retweetButton.setImage(UIImage(named:image), for: UIControl.State.normal)
    }
    
}
