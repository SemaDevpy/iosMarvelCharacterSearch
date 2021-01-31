//
//  ThirdViewController.swift
//  MarvelCharacterSearch
//
//  Created by Syimyk on 1/31/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    
    var stories : [String] = []
    var comics  : [String] = []
    var events  : [String] = []
    var series  : [String] = []
    var tag = 0
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}

//MARK: - TableView Data Source Methods
extension ThirdViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tag{
        case 0:
            return comics.count
        case 1:
            return series.count
        case 2:
            return stories.count
        case 3:
            return events.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        switch tag{
             case 0:
                cell.textLabel?.text = comics[indexPath.row]
                 return cell
             case 1:
                 cell.textLabel?.text = series[indexPath.row]
                 return cell
             case 2:
                 cell.textLabel?.text = stories[indexPath.row]
                 return cell
             case 3:
                 cell.textLabel?.text = events[indexPath.row]
                 return cell
             default:
                 cell.textLabel?.text = "no data"
                 return cell
             }
        
        
        
        
    }
    
}
