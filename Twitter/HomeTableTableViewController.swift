//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Brian Martin on 10/14/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
    }
    
    func loadTweets(){
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": 10]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: params, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
        }, failure: { (Error) in
            print("Tweet Request Failed")
        })
    }

    // MARK: - Table view data source
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        if let imageData = data{
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }

}
