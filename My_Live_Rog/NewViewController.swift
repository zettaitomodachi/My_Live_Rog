//
//  nikkiViewController.swift
//  nikki
//
//  Created by 妙中美月 on 2018/07/01.
//  Copyright © 2018年 妙中美月. All rights reserved.
//

import UIKit

class nikkiViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var artistTextField:UITextField!
    @IBOutlet var kaienTextField:UITextField!
    @IBOutlet var kaijoTextField:UITextField!
    @IBOutlet var dateTextField:UITextField!
    @IBOutlet var placeTextField:UITextField!
    @IBOutlet var finishTextField: UITextField!
    @IBOutlet var ticketTextField: UITextField!

    
    
    var datePicer: UIDatePicker = UIDatePicker()
    var timePIcer: UIDatePicker = UIDatePicker()
    
    
    
    var saveData:UserDefaults = UserDefaults.standard
    var dataCount: Int = 0
    var id:String!
    var data: Dictionary = [
        "title":"",
        "artist":"",
        "date":"",
        "kaien":"",
        "kaijo":"",
        "setList":"",
        "place":"",
        "finish":"",
        "ticket":"",
        
        
    ]
    var kako_ALLData:[Any] = []
    var mirai_ALLData:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if saveData.object(forKey: "kako") != nil{
            kako_ALLData = saveData.array(forKey: "kako") as! [Dictionary<String, String>]
        }else if saveData.object(forKey: "mirai") != nil{
            mirai_ALLData = saveData.array(forKey: "mirai") as! [Dictionary<String, String>]
        }
        
        titleTextField.delegate = self
        artistTextField.delegate = self
        placeTextField.delegate = self
        
        
        titleTextField.placeholder = "ライブ名"
        artistTextField.placeholder = "アーティスト名"
        kaienTextField.placeholder = "開演時間"
        kaijoTextField.placeholder = "会場時間"
        dateTextField.placeholder = "日付"
        placeTextField.placeholder = "場所"
        ticketTextField.placeholder = "チケット代金"
        
        
        
        // 日付
        datePicer.datePickerMode = .date
        datePicer.timeZone = NSTimeZone.local
        datePicer.locale = Locale(identifier: "ja")
        
        //日付のツールバー
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        // インプットビュー
        dateTextField.inputView = datePicer
        dateTextField.inputAccessoryView = toolbar
        
        // じか
        timePIcer.datePickerMode = .time
        timePIcer.locale = Locale(identifier: "ja")
        
        let timeToolbar = UIToolbar(frame: CGRect(x: 0, y:0, width: view.frame.size.width, height: 35))
        let doneTimeItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTime))
        timeToolbar.setItems([spacelItem, doneTimeItem], animated: true)
        
        let timeToolbar2 = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let doneTimeItem2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTime2))
        timeToolbar2.setItems([spacelItem, doneTimeItem2], animated: true)
        
//        let timeToolbar3 = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
//        let doneTimeItem3 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTime3))
//        timeToolbar3.setItems([spacelItem, doneTimeItem3], animated: true)
//
        
        kaienTextField.inputView = timePIcer
        kaijoTextField.inputView = timePIcer
        kaienTextField.inputAccessoryView = timeToolbar
        kaijoTextField.inputAccessoryView = timeToolbar2
//        finishTextField.inputAccessoryView = timeToolbar3
        
        
        
        /*
        print("check")
        print(saveData.bool(forKey: "nikkiAllData"))
        if saveData.bool(forKey: "nikkiAllData"){
            saveData = saveData.object(forKey: "nikkiAllData") as! [Any]
        }
        //        titleTextField.text = saveData.object(forKey:"title") as? String
        //        contentTextView.text = saveData.object(forKey:"content") as? String
        //        whenTextField.text = saveData.object(forKey:"when") as? String
        //        whereTextField.text = saveData.object(forKey:"where") as? String
        //        whoTextField.text = saveData.object(forKey:"who") as? String
        //        whatTextField.text = saveData.object(forKey:"what") as? String
        //        howTextField.text = saveData.object(forKey:"how") as? String
        
 // Do any additional setup after loading the view.*/
    }
    
    @objc func done() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        dateTextField.text = "\(formatter.string(from: datePicer.date))"
        dateTextField.endEditing(true)
    }
    
    @objc func doneTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        kaienTextField.text = "\(formatter.string(from: timePIcer.date))"
        kaienTextField.endEditing(true)
    }
    @objc func doneTime2() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        kaijoTextField.text = "\(formatter.string(from: timePIcer.date))"
        kaijoTextField.endEditing(true)
        
    }

//@objc func doneTime3() {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "HH:mm"
//            kaijoTextField.text = "\(formatter.string(from: timePIcer.date))"
//            kaijoTextField.endEditing(true
//            )
//        }
    
    
    @IBAction func saveMiraiButton(){
        let keyword = "mirai"
        save(keyword: keyword)
        alert()
        shokika()
    }
    @IBAction func saveKakoButton(){
        let keyword = "kako"
        save(keyword :keyword)
        alert()
        shokika()
    }
    
    func shokika(){//
        titleTextField.text = ""
        artistTextField.text = ""
        dateTextField.text = ""
        kaijoTextField.text = ""
        kaienTextField.text = ""
        placeTextField.text = ""
        ticketTextField.text = ""
    }
    
    func alert(){
        let alert: UIAlertController = UIAlertController(title:"登録完了",message:"ライブの登録が完了しました",preferredStyle:.alert)
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: {action in print("OKされたで")}
        )
    )
        present(alert, animated: true, completion: nil)
    }
    
    func save (keyword: String){
        data["title"] = titleTextField.text
        data["artist"] = artistTextField.text
        data["date"] = dateTextField.text
        data["kaien"] = kaienTextField.text
        data["kaijo"] = kaijoTextField.text
        data["place"] = placeTextField.text
        data["ticket"] = ticketTextField.text
        
        
        
        if keyword == "kako"{
            kako_ALLData.append(data)
            saveData.set(kako_ALLData, forKey: keyword)
            saveData.synchronize()
        }else{
            mirai_ALLData.append(data)
            saveData.set(mirai_ALLData, forKey: keyword)
            saveData.synchronize()
        }
        
        
    }

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
    
    
    
  }
}

