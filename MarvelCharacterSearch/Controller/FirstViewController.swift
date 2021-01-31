//
//  ViewController.swift
//  MarvelCharacterSearch
//
//  Created by Syimyk on 1/23/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import UIKit
import SDWebImage

class FirstViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let marvelManager = MarvelManager()
    var result : [CharacterModel] = []

    var emptyResults = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        marvelManager.fetchCharacter()
        marvelManager.delegate = self
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
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.nameLabel.text = result[indexPath.row].name
        
        if result[indexPath.row].image != " "{
            cell.imageView.sd_setImage(with: URL(string: "\(result[indexPath.row].image)/portrait_medium.jpg")  , completed: nil)
        }else{
            cell.imageView.image = UIImage(named: "iron-man")
        }

        return cell
    }
    
    

    
}

//MARK: - UICollectionViewDelegate
extension FirstViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToHero", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SecondViewController
        if let indexPath = collectionView.indexPathsForSelectedItems?.first?.row{
            destinationVC.heroName = result[indexPath].name
            destinationVC.heroDescription = result[indexPath].description
            destinationVC.seriesList = result[indexPath].series
            destinationVC.comicsList = result[indexPath].comics
            destinationVC.storiesList = result[indexPath].stories
            destinationVC.eventsList = result[indexPath].events
        }
        
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
//MARK: - MarvelManagerDelegate
extension FirstViewController : MarvelManagerDelegate{
    func didUpdateBook(_ marvelManager: MarvelManager, characters: [CharacterModel]) {
        result = characters
        searchBar.placeholder = "search..."
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print("error")
    }
    
    func noResult() {
        searchBar.placeholder = "No results, search again..."
    }
    
}
