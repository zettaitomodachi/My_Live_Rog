//
//  nikkiViewController.swift
//  nikki
//
//  Created by 妙中美月 on 2018/07/01.
//  Copyright © 2018年 妙中美月. All rights reserved.
//

import UIKit
import Alertift

class nikkiViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var artistTextField:UITextField!
    @IBOutlet var kaienTextField:UITextField!
    @IBOutlet var kaijoTextField:UITextField!
    @IBOutlet var dateTextField:UITextField!
    @IBOutlet var placeTextField:UITextField!
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
        
        let gradation = CAGradientLayer()
        let topcolor = UIColor.init(red: 166/255, green: 192/255, blue: 1, alpha: 1)
        let bottomcolor = UIColor.init(red: 246/255, green: 128/255, blue: 132/255, alpha: 1)
        gradation.colors = [topcolor.cgColor, bottomcolor.cgColor]
        gradation.frame = view.frame
        view.layer.insertSublayer(gradation, at: 0)
        
        
        titleTextField.delegate = self
        artistTextField.delegate = self
        placeTextField.delegate = self
        
        ticketTextField.keyboardType = .numberPad
        
        
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
    
    
    @IBAction func saveMiraiButton() {
        let keyword = "mirai"
        save(keyword: keyword)
        alert()
        shokika()
    }
    @IBAction func saveKakoButton() {
        let keyword = "kako"
        save(keyword :keyword)
        alert()
        shokika()
    }
    
    func shokika() {//
        titleTextField.text = ""
        artistTextField.text = ""
        dateTextField.text = ""
        kaijoTextField.text = ""
        kaienTextField.text = ""
        placeTextField.text = ""
        ticketTextField.text = ""
    }
    
    func alert(){
        Alertift
            .alert(title:"登録完了", message: "ライブの登録が完了しました")
            .action(.default("OK"))
            .show()
    }
    
    func save (keyword: String){
        
        if titleTextField.text != "" && artistTextField?.text != "" && dateTextField.text != "" {
            data["title"] = titleTextField.text
            data["artist"] = artistTextField.text
            data["date"] = dateTextField.text
            data["kaien"] = kaienTextField.text
            data["kaijo"] = kaijoTextField.text
            data["place"] = placeTextField.text
            data["ticket"] = ticketTextField.text
            
            if keyword == "kako" {
                kako_ALLData.append(data)
                saveData.set(kako_ALLData, forKey: keyword)
                saveData.synchronize()
            } else {
                mirai_ALLData.append(data)
                saveData.set(mirai_ALLData, forKey: keyword)
                saveData.synchronize()
            }
        } else {
            
            Alertift
                .alert(title: "保存できません", message: "保存するには「タイトル」「アーティスト」「日付」が必要です")
                .action(.default("OK"))
                .show()
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

