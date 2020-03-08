//
//  nikkiViewController.swift
//  nikki
//
//  Created by 妙中美月 on 2018/07/01.
//  Copyright © 2018年 妙中美月. All rights reserved.
//

import UIKit
import Alertift

class NewLiveViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: 変数
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var artistTextField:UITextField!
    @IBOutlet var openTextField:UITextField!
    @IBOutlet var startTextField:UITextField!
    @IBOutlet var dateTextField:UITextField!
    @IBOutlet var placeTextField:UITextField!
    @IBOutlet var ticketTextField: UITextField!
    
    @IBOutlet var liveImageView: UIImageView!
    
    var datePicker: UIDatePicker = UIDatePicker()
    var timePikcer: UIDatePicker = UIDatePicker()
    
    var userDefaults:UserDefaults = UserDefaults.standard
    var liveDataArray: [[String: Any?]] = []
    var liveData: [String:Any?] = [ "title" : "",
                                    "artist" : "",
                                    "date" : "",
                                    "open" : "",
                                    "start" : "",
                                    "place" : "",
                                    "ticket" : "",
                                    "liveImageData" : nil]
    
    // MARK: 上書きするメソッド
    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景色の設定
        let gradation = CAGradientLayer()
        let topcolor = UIColor.init(red: 166/255, green: 192/255, blue: 1, alpha: 1)
        let bottomcolor = UIColor.init(red: 246/255, green: 128/255, blue: 132/255, alpha: 1)
        gradation.colors = [topcolor.cgColor, bottomcolor.cgColor]
        gradation.frame = view.frame
        view.layer.insertSublayer(gradation, at: 0)
        
        // TextFieldのdelegateの設定
        titleTextField.delegate = self
        artistTextField.delegate = self
        placeTextField.delegate = self
        
        // 入力を数字キーボードに設定
        ticketTextField.keyboardType = .numberPad
        
        // datePickerの設定
        datePicker.datePickerMode = .date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale(identifier: "ja")
        
        //日付のツールバーを作る
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビューの設定
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
        
        // timePickerの設定
        timePikcer.datePickerMode = .time
        timePikcer.locale = Locale(identifier: "ja")
        
        // 時間のツールバーを作る
        let timeToolbar = UIToolbar(frame: CGRect(x: 0, y:0, width: view.frame.size.width, height: 40))
        let doneTimeItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTime))
        timeToolbar.setItems([spacelItem, doneTimeItem], animated: true)
        
        let timeToolbar2 = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        let doneTimeItem2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTime2))
        timeToolbar2.setItems([spacelItem, doneTimeItem2], animated: true)
        
        // インプットビューの設定
        startTextField.inputView = timePikcer
        openTextField.inputView = timePikcer
        startTextField.inputAccessoryView = timeToolbar
        openTextField.inputAccessoryView = timeToolbar2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // UserDefaultsから保存データを読み込み
        if userDefaults.object(forKey: "LiveDataArray") != nil {
            liveDataArray = userDefaults.object(forKey: "LiveDataArray") as! [[String: Any?]]
        }
        else {
            print("まだデータがありません")
        }
    }
    
    // MARK: その他のメソッド
    @objc func done() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        dateTextField.text = "\(formatter.string(from: datePicker.date))"
        dateTextField.endEditing(true)
    }
    
    @objc func doneTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        startTextField.text = "\(formatter.string(from: timePikcer.date))"
        startTextField.endEditing(true)
    }
    
    @objc func doneTime2() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        openTextField.text = "\(formatter.string(from: timePikcer.date))"
        openTextField.endEditing(true)
    }
    
    @IBAction func selectImage() {
        let imagePickerViewController = UIImagePickerController()
        
        imagePickerViewController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerViewController.delegate = self
        
        self.present(imagePickerViewController, animated: true)
    }
    
    @IBAction func save() {
        saveData()
        alert()
        initialize()
    }
    
    func initialize() {
        titleTextField.text = ""
        artistTextField.text = ""
        dateTextField.text = ""
        openTextField.text = ""
        startTextField.text = ""
        placeTextField.text = ""
        ticketTextField.text = ""
        liveImageView.image = nil
    }
    
    func alert(){
        Alertift
            .alert(title:"登録完了", message: "ライブの登録が完了しました")
            .action(.default("OK"))
            .show()
    }
    
    func saveData (){
        if titleTextField.text != "" && artistTextField?.text != "" && dateTextField.text != "" {
            liveData["title"] = titleTextField.text
            liveData["artist"] = artistTextField.text
            liveData["date"] = dateTextField.text
            liveData["open"] = openTextField.text
            liveData["start"] = startTextField.text
            liveData["place"] = placeTextField.text
            liveData["ticket"] = ticketTextField.text
            if liveImageView.image != nil {
                liveData["liveImageData"] = liveImageView.image?.jpegData(compressionQuality: 1)
            } else {
                liveData["liveImageData"] = UIImage(named: "Live.jpeg")?.jpegData(compressionQuality: 1)
            }
            
            liveDataArray.insert(liveData, at: 0)
            userDefaults.set(liveDataArray, forKey: "LiveDataArray")
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        liveImageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
}

