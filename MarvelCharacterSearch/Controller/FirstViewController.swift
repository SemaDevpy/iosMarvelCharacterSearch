//
//  ViewController.swift
//  MarvelCharacterSearch
//
//  Created by Syimyk on 1/23/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let marvelManager = MarvelManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}

