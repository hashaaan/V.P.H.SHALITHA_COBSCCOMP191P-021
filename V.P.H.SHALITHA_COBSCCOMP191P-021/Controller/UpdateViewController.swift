//
//  UpdateViewController.swift
//  NIBM COVID19
//
//  Created by HASHAN on 9/4/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit
import FirebaseAuth

class UpdateViewController: UIViewController {
    
    // MARK: - Properties
    
    private var user: User? {
        didSet {
            tempLbl.text = "\(user!.temperature)°C"
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "CREATE+"
        label.font = UIFont(name: "Avenir-Light", size: 30)
        label.textColor = .black
        return label
    }()
    
    private let notificTile: UIButton = {
        let tile = UIButton()
        tile.backgroundColor = .white
        tile.layer.cornerRadius = 5
        tile.layer.masksToBounds = true
        tile.addTarget(self, action: #selector(showNotifications), for: .touchUpInside)
        
        let title = UILabel()
        title.text = "Create Notifications"
        title.font = UIFont(name: "Avenir-Medium", size: 18)
        title.textColor = UIColor.black
        tile.addSubview(title)
        title.anchor(left: tile.leftAnchor, paddingLeft: 20)
        title.centerY(inView: tile)
        
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "chevron.right")
        arrow.tintColor = .black
        arrow.layer.masksToBounds = true
        tile.addSubview(arrow)
        arrow.anchor(right: tile.rightAnchor, paddingRight: 20, width: 14, height: 24)
        arrow.centerY(inView: tile)
        
        return tile
    }()
    
    private let surveyTile: UIButton = {
        let tile = UIButton()
        tile.backgroundColor = .white
        tile.layer.cornerRadius = 5
        tile.layer.masksToBounds = true
        tile.addTarget(self, action: #selector(showNewSurvey), for: .touchUpInside)
        
        let title = UILabel()
        title.text = "New Survey"
        title.font = UIFont(name: "Avenir-Medium", size: 18)
        title.textColor = UIColor.black
        tile.addSubview(title)
        title.anchor(left: tile.leftAnchor, paddingLeft: 20)
        title.centerY(inView: tile)
        
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "chevron.right")
        arrow.tintColor = .black
        arrow.layer.masksToBounds = true
        tile.addSubview(arrow)
        arrow.anchor(right: tile.rightAnchor, paddingRight: 20, width: 14, height: 24)
        arrow.centerY(inView: tile)
        
        return tile
    }()
    
    private let tempTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 5.0
        tf.layer.masksToBounds = true
        tf.keyboardType = .decimalPad
        tf.textAlignment = .center
        return tf
    }()
    
    private let tempLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "0°C"
        lbl.font = UIFont.systemFont(ofSize: 46)
        return lbl
    }()
    
    private lazy var tempTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .white
        tile.layer.cornerRadius = 5
        tile.layer.masksToBounds = true
        
        tile.addSubview(tempLbl)
        tempLbl.anchor(top: tile.topAnchor, paddingTop: 40)
        tempLbl.centerX(inView: tile)
        
        let timeAgo = UILabel()
        timeAgo.text = "Last Update: 1 Day ago"
        timeAgo.font = UIFont.systemFont(ofSize: 12)
        timeAgo.textColor = .darkGray
        tile.addSubview(timeAgo)
        timeAgo.anchor(top: tempLbl.bottomAnchor, paddingTop: 20)
        timeAgo.centerX(inView: tile)
        
        tile.addSubview(tempTF)
        tempTF.anchor(top: timeAgo.bottomAnchor, paddingTop: 40, width: 100)
        tempTF.centerX(inView: tile)
        
        let tempBtn = UIButton()
        tempBtn.setTitle("UPDATE", for: .normal)
        tempBtn.setTitleColor(.black, for: .normal)
        tempBtn.layer.borderColor = UIColor.black.cgColor
        tempBtn.layer.borderWidth = 0.5
        tempBtn.layer.cornerRadius = 5.0
        tempBtn.layer.masksToBounds = true
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tempBtn.addTextSpacing(2)
        tempBtn.addTarget(self, action: #selector(handleTempUpdate), for: .touchUpInside)
        tile.addSubview(tempBtn)
        tempBtn.anchor(top: tempTF.bottomAnchor, paddingTop: 35, width: 120, height: 40)
        tempBtn.centerX(inView: tile)
        
        return tile
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        let screensize: CGRect = UIScreen.main.bounds
        sv.contentSize = CGSize(width: screensize.width - 2.0, height: screensize.height)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        self.fetchUserData()
    }
    
    // MARK: - Selectors
    
    @objc func showNotifications() {
        let vc = CreateNotificVC()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showNewSurvey() {
        let vc = SurveyVC01()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleTempUpdate() {
        guard let temp = tempTF.text else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let temperature = Float(temp)
        
        // 102°F - 103°F for COVID19
        // 38.8°C - 39.4°C for COVID19
        
        if temperature == nil {
            let alert = UIAlertController(title: "Temprature is Required!", message: "Please enter your body temprature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        } else if (temperature! < 34.0) || (temperature! > 47.0)  {
            let alert = UIAlertController(title: "Invalid Temprature!", message: "Body temprature cannot be lessthan 34°C or greaterthan 47°C", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        self.view.endEditing(true)
        let values = [
            "temperature": temp,
            "tempDate": [".sv": "timestamp"]
        ] as [String : Any]
        self.uploadUserTemperature(uid: currentUid, values: values)
        self.tempTF.text = ""
    }
    
    // MARK: - API
    
    func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.shared.fetchUserData(uid: currentUid) { (user) in
            self.user = user
            self.configUI()
        }
    }
    
    // MARK: - Helper Functions
    
    func configUI() {
        configNavBar()
        view.backgroundColor = .systemGray6
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        titleLabel.centerX(inView: view)
        
        view.addSubview(scrollView)
        scrollView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 1.0, paddingLeft: 1.0, paddingBottom: -1.0, paddingRight: -1.0)
        
        scrollView.addSubview(notificTile)
        
        if (user?.role ?? "") as String == "Admin" {
            notificTile.anchor(top: scrollView.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)
        }
        
        scrollView.addSubview(surveyTile)
        surveyTile.anchor(top: notificTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)
        
        scrollView.addSubview(tempTile)
        tempTile.anchor(top: surveyTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16, height: 300)
    }
    
    func configNavBar() {
        //navigationController?.navigationBar.barTintColor = .lightGray
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    func uploadUserTemperature(uid: String, values: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
            if error == nil {
                print("No error")
                //self.tempLbl.text = values.first?.value as? String
                self.tempLbl.text = "\(values["temperature"] as? String ?? "0")°C"
            }
        }
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
}
