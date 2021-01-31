//
//  SecondViewController.swift
//  MarvelCharacterSearch
//
//  Created by Syimyk on 1/29/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var heroName = ""
    var heroDescription = ""
    var storiesList : [String] = []
    var comicsList  : [String] = []
    var eventsList  : [String] = []
    var seriesList  : [String] = []
    
    
    @IBOutlet weak var comics: UIButton!
    @IBOutlet weak var series: UIButton!
    @IBOutlet weak var stories: UIButton!
    @IBOutlet weak var events: UIButton!
    @IBOutlet weak var wevsite: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = heroName
        switch heroDescription {
        case "":
            descriptionTextView.text = "No Description For This Character"
        default:
            descriptionTextView.text = heroDescription
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: nil, action: nil)
        comics.makeCircle()
        series.makeCircle()
        stories.makeCircle()
        events.makeCircle()
        wevsite.makeCircle()
    }
    
    
    
    @IBAction func btnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTables", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ThirdViewController
        if let button = sender as? UIButton {
            destinationVC.tag = button.tag
            destinationVC.comics = comicsList
            destinationVC.stories = storiesList
            destinationVC.series = seriesList
            destinationVC.events = eventsList
        }
    }
    
    
    @IBAction func goToWebsitePressed(_ sender: UIButton) {
        guard let url = URL(string: "https://www.marvel.com/") else { return }
        UIApplication.shared.open(url)
    }
    
    
}







extension UIButton{
    func makeCircle(){
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
}
