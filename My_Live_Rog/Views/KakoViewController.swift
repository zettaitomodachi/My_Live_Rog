//
//  KakoViewController.swift
//  My_Live_Rog
//
//  Created by 妙中美月 on 2019/07/21.
//  Copyright © 2019 妙中美月. All rights reserved.
//

import UIKit

class KakoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var collectionView: UICollectionView!
    let margin: CGFloat = 15
    
    var saveData:UserDefaults = UserDefaults.standard
    let keyword: String = "kako"
    //var allData:[Any] = []
    
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
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        collectionView.collectionViewLayout = layout
        
        //        let iroNum = Int.random(in: 10...255)
        //        iro = UIColor(red: 50/255, green: 5/255, blue: CGFloat(iroNum/255), alpha: 1)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("kako",allData.count)
        return self.allData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kakoLiveCell", for: indexPath) // 表示するセルを登録
        //        cell.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0..<50)/255), green: CGFloat(Int.random(in: 0..<5)/255), blue: CGFloat(Int.random(in: 100..<255)/255), alpha: 1)  // セルの色
        cell.backgroundColor = UIColor(red: 0/255, green: 102/255, blue: 255/255, alpha: 1)
        // Tag番号を使ってLabelのインスタンス生成
        let label = cell.contentView.viewWithTag(1) as! UILabel
        
        label.text = allData[indexPath.row]["title"]
        
        //        label.text = titleArray[indexPath[1]]
        //        print(indexPath[1],titleArray[indexPath[1]])
        //        print("index",indexPath)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize : CGFloat = (UIScreen.main.bounds.width - margin*3) / 2
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // cellが押された時の処理を書く
        receipt = allData[indexPath.row]
        performSegue(withIdentifier: "KakoToReceiptSegue", sender: nil) //画面遷移
        
    }
    
    // 画面遷移先のViewControllerを取得し、データを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "KakoToReceiptSegue" {
            let vc = segue .destination as?ViewController
            let _ = vc?.view
            
            vc?.titleLabel.text = receipt["title"]!
            vc?.livehouseLabel.text = receipt["place"]!
            vc?.openLabel.text = receipt["kaijo"]!
            vc?.whoseLabel.text = receipt["artist"]!
            vc?.dateLabel.text = receipt["date"]!
            vc?.ticketLabel.text = receipt["ticket"]!
            vc?.stertLabel.text = receipt["kaien"]!
            
            
            
        }
        
    }
}
