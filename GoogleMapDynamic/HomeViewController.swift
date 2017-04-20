//
//  HomeViewController.swift
//  GoogleMapDynamic
//
//  Created by Minea Chem on 3/31/17.
//  Copyright © 2017 Minea Chem. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    struct objectMaps{
        var imagesMap:UIImage
        var titleMap:String
    }
    var objectMapArray: [objectMaps] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        objectMapArray.append(objectMaps(imagesMap: UIImage(named: "add_marker")!, titleMap: "Create a Map with Marker"))
        objectMapArray.append(objectMaps(imagesMap: UIImage(named: "style_map")!, titleMap: "Style Map"))
        objectMapArray.append(objectMaps(imagesMap:
            UIImage(named: "currentPlace")!, titleMap: "currentPlace"))
        objectMapArray.append(objectMaps(imagesMap: UIImage(named: "duration_distance")!, titleMap: "duration and distance"))
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }

    
    
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectMapArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as! CollectionViewCell
        cell.imageMap.image = objectMapArray[indexPath.row].imagesMap
        cell.titleMap.text = objectMapArray[indexPath.row].titleMap
        //cell.imageMap.tag = indexPath.row

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
           performSegue(withIdentifier: "viewLocation", sender: self)
        }else if indexPath.row == 1{
            print("other 1")
        } else if indexPath.row == 2 {
            performSegue(withIdentifier: "currentLocation", sender: self)

        }else if indexPath.row == 3 {
            performSegue(withIdentifier: "distanceMap", sender: self)
        }
       
    }
        
}
