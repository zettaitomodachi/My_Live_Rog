//
//  KakoViewController.swift
//  My_Live_Rog
//
//  Created by 妙中美月 on 2019/07/21.
//  Copyright © 2019 妙中美月. All rights reserved.
//

import UIKit

class FutureViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FutureLiveCell", for: indexPath) as? CustomCollectionViewCell
        cell?.configure(liveImage: #imageLiteral(resourceName: "Live.jpeg"), liveDate: "2019.9.8", liveTitle: "OTODAMA", artist: "清水音泉")
        return cell!
    }
    
    
    
    @IBOutlet var collectionView: UICollectionView!
    let margin: CGFloat = 15
    
    var saveData:UserDefaults = UserDefaults.standard
    let keyword: String = "Future"
    var allData: [Dictionary<String, String>] = []
    var receipt: [String: String] = [:]
    var iro: UIColor!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let gradation = CAGradientLayer()
        let topcolor = UIColor.init(red: 166/255, green: 192/255, blue: 1, alpha: 1)
        let bottomcolor = UIColor.init(red: 246/255, green: 128/255, blue: 132/255, alpha: 1)
        gradation.colors = [topcolor.cgColor, bottomcolor.cgColor]
        gradation.frame = view.frame
        view.layer.insertSublayer(gradation, at: 0)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FutureLiveCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if saveData.object(forKey: keyword) == nil {
            print("まだデータがありません")
            
        } else {
            allData = saveData.array(forKey: keyword)! as! [Dictionary<String,String>]
            
        }
    }
}

struct FutureLiveData {
    let imageData: Data?
    let date: String
    let liveTitle: String
    let artistName: String
    let place: String
}

