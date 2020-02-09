    //
    //  KakoViewController.swift
    //  My_Live_Rog
    //
    //  Created by 妙中美月 on 2019/07/21.
    //  Copyright © 2019 妙中美月. All rights reserved.
    //

    import UIKit

    class PastViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
        
        @IBOutlet var collectionView: UICollectionView!
        
        var userDefaults: UserDefaults = UserDefaults.standard
        var liveDataArray: [[String: Any?]] = []
        var pastLiveDataArray: [[String: Any?]] = []
        var receiptInfo: [String: Any?] = [:]
        
        var allData: [Dictionary<String, String>] = []
        
        
        
        var receipt: [String:String] = [:]
        
        
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
            
            collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pastLiveCell")

        }
        
        override func viewWillAppear(_ animated: Bool) {
                    super.viewWillAppear(animated)
                    // 一度空にする
                    liveDataArray.removeAll()
                    pastLiveDataArray.removeAll()
                    
                    // UserDefaultsから保存データを読み込み
                    if userDefaults.object(forKey: "LiveDataArray") != nil {
                        liveDataArray = userDefaults.object(forKey: "LiveDataArray") as! [[String: Any?]]
                        
                        for liveData in liveDataArray {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy.MM.dd"

                            let date = formatter.date(from: liveData["date"] as! String)!
                            
                            if date < Date() {
                                pastLiveDataArray.append(liveData)
                            }
                        }
                    }
                    else {
                        print("まだデータがありません")
                    }
                    
                    // CollectionViewを更新
                    collectionView.reloadData()
                }
                
                override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    if (segue.identifier == "pastToReceiptSegue") {
                        let vc = segue.destination as?ViewController
                        let _ = vc?.view

                        vc?.titleLabel.text = receiptInfo["title"] as? String
                        vc?.livehouseLabel.text = receiptInfo["place"] as? String
                        vc?.artistLabel.text = receiptInfo["artist"] as? String
                        vc?.dateLabel.text = receiptInfo["date"] as? String
                        vc?.openLabel.text = receiptInfo["open"] as? String
                        vc?.stertLabel.text = receiptInfo["start"] as? String
                        vc?.ticketLabel.text = receiptInfo["ticket"] as? String
                        vc?.liveImageView.image = UIImage(data: receiptInfo["liveImageData"] as! Data)
                    }
                }
                
                // MARK: collectionViewのDelegateメソッド
                func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                    return pastLiveDataArray.count
                }
                
                func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pastLiveCell", for: indexPath) as? CustomCollectionViewCell
                    
                    cell?.configure(
                        liveImage: UIImage(data: pastLiveDataArray[indexPath.row]["liveImageData"] as! Data)!,
                        liveDate: pastLiveDataArray[indexPath.row]["date"] as! String,
                        liveTitle: pastLiveDataArray[indexPath.row]["title"] as! String,
                        artist: pastLiveDataArray[indexPath.row]["artist"] as! String
                    )
                    
                    return cell!
                }
                
                func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                    receiptInfo = pastLiveDataArray[indexPath.row]
                    performSegue(withIdentifier: "pastToReceiptSegue", sender: nil)
                }
            }
