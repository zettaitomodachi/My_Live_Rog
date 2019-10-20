//
//  KakoViewController.swift
//  My_Live_Rog
//
//  Created by 妙中美月 on 2019/07/21.
//  Copyright © 2019 妙中美月. All rights reserved.
//

import UIKit

class MiraiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var miraicollectionView: UICollectionView!
    let margin: CGFloat = 15
    
    var saveData:UserDefaults = UserDefaults.standard
    let keyword: String = "mirai"
    //    var allData:[Any] = []
    var allData: [Dictionary<String, String>] = []
    
    var receipt: [String:String] = [:]
    
    var iro: UIColor!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if saveData.object(forKey: keyword) == nil{
            print("まだデータがありません")
            
        }else{
            allData = saveData.array(forKey: keyword)! as! [Dictionary<String,String>]
            
            //            allData = saveData.object(forKey: keyword) as! [Any]
            //            for item in allData as! [[String:Any]]{
            //                titleArray.append(item["title"]! as! String)
            //                print(titleArray)
            //            }
        }
        
        self.miraicollectionView.delegate = self
        self.miraicollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        miraicollectionView.collectionViewLayout = layout
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("mirai",allData.count)
        return self.allData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "miraiLiveCell", for: indexPath) // 表示するセルを登録
        
        cell.backgroundColor = UIColor(red: 0/255, green: 102/255, blue: 255/255, alpha: 1)
        // Tag番号を使ってLabelのインスタンス生成
        let label = cell.contentView.viewWithTag(1) as! UILabel
        
        //        label.text = titleArray[indexPath[1]]
        
        label.text = allData[indexPath.row]["title"]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize : CGFloat = (UIScreen.main.bounds.width - margin*3) / 2
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // cellが押された時の処理を書く
        receipt = allData[indexPath.row]
        performSegue(withIdentifier: "miraiToReceiptSegue", sender: nil) //画面遷移
        
    }
    
    // 画面遷移先のViewControllerを取得し、データを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MiraiToReceiptSegue" {
            let vc = segue.destination as?ViewController
            let _ = vc?.view
            
            vc?.titleLabel.text = receipt["title"]!
            vc?.livehouseLabel.text = receipt["place"]!
            vc?.openLabel.text = receipt["kaijo"]!
            vc?.whoseLabel.text = receipt["artist"]!
            vc?.dateLabel.text = receipt["date"]!
            vc?.ticketLabel.text = receipt["ticket"]!
        }
    }
}


