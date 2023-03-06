//
//  TableViewController.swift
//  EasyBrowser
//
//  Created by Halil Bakar on 6.03.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    var websites = ["apple.com", "hackingwithswift.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Websites"
      
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Websites", for: indexPath)
        
        cell.textLabel?.text = websites[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webVC = storyboard?.instantiateViewController(withIdentifier: "WebView") as! ViewController
            
        webVC.webSiteLoad = websites[indexPath.row]
        
        navigationController?.pushViewController(webVC, animated: true)
        
    }
}
