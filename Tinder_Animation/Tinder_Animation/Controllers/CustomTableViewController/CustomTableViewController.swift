//
//  CustomTableViewController.swift
//  Tinder_Animation
//
//  Created by Gagan  Vishal on 10/30/20.
//

import UIKit

class CustomTableViewController: UITableViewController {
    
    let cellIdentifireString = "reuseIdentifier"
    
    enum animations: String, CaseIterable  {
        
        case customLoader = "customLoader"
        case customPopUp = "customPopUp"
        case circularProgress = "circularProgress"
        case cusstomGridView  = "customGridView"
        case facebookLikeAnimation = "fbLikeAnimation"
    }
    
    //MARK:- View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  animations.allCases.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifireString, for: indexPath)
        cell.textLabel?.text = animations.allCases[indexPath.row].rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let switchCases = animations.allCases[indexPath.row]
        switch switchCases {
        case .circularProgress:
            self.performSegue(withIdentifier: switchCases.rawValue, sender: self)
        case .customLoader:
            break
        case .customPopUp:
            break
        case .cusstomGridView:
           self.performSegue(withIdentifier: switchCases.rawValue, sender: self)
        case .facebookLikeAnimation:
           self.navigationController?.pushViewController(FacebookLikeViewController(), animated: true)
        }
    }
    
}
