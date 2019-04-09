//
//  PhotosViewController.swift
//  TumblrLab
//
//  Created by Lily Pham on 4/7/19.
//  Copyright © 2019 Lily Pham. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // Initialize to empty array so we don't worry about it being nil later
    var posts: [[String: Any]] = []
    // called everytime the screen loads
    override func viewDidLoad() {
        super.viewDidLoad()
        // control over the tableview
        tableView.delegate = self
        // control over the datasource
        tableView.dataSource = self
        tableView.rowHeight = 250
        // Do any additional setup after loading the view.
        
        // call getPosts
        getPosts()
    }
    
    func getPosts(){
        // posts in is like python lambda: x
        API().getPosts(){ (posts) in
            // gaurd statement check if posts exists
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
            }
            
        }
    }
    // numberofrowsinsection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    // var = variable that can be changed
    // let = constant variable
    // cellforrowsat = called everytime a new cell is built
    // indexpath = # cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // as! certain that this is a photocell
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        let post = posts[indexPath.row]
        
        // as? not sure of data type
        if let photos = post["photos"] as? [[String:Any]]{
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String:Any]
            let urlString = originalSize["url"] as! String
            
            // CocoaPods is a dependancy manager
            let url = URL(string: urlString)
            cell.PhotoView.af_setImage(withURL: url!)
        }
        return cell
    }

}
