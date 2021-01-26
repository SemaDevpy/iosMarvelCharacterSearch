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
    var result : [CharacterModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        marvelManager.fetchCharacter()
        
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        
        
//
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 200, height: 300)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }
    

}


//MARK: - UISearchBarDelegate
extension FirstViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        marvelManager.fetchCharacter(with: searchBar.text)
        searchBar.text = ""
    }
}


//MARK: - DataSource Methods
extension FirstViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.nameLabel.text = "Iron Man"
        cell.imageView.image = UIImage(named: "iron-man")
        return cell
    }
    
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 4
//    }
    
}

//MARK: - UICollectionViewDelegate
extension FirstViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Im tapped")
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension FirstViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - (3 * 15)) / 2
        
        return CGSize(width: width, height: 220)
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    
    
    

}
