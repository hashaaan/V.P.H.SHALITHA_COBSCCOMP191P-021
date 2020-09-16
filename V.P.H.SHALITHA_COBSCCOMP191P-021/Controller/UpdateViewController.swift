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
            tempLbl.text = user!.temperature
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "CREATE+"
        label.font = UIFont(name: "Avenir-Light", size: 30)
        label.textColor = .black
        return label
    }()
    
    // Notifications tile
    
    private let notificationsTile: UIButton = {
        let tileView = UIButton()
        tileView.backgroundColor = .white
        tileView.layer.cornerRadius = 5
        tileView.layer.masksToBounds = true
        tileView.addTarget(self, action: #selector(showNotifications), for: .touchUpInside)
        return tileView
    }()
    
    private let notificationsTileLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Notifications"
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textColor = UIColor.black
        //label.backgroundColor = .red
        return label
    }()
    
    private let notificationsTileButton: UIButton = {
        let button = UIButton(type: .custom)
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: boldConfig), for: .normal)
        //button.backgroundColor = .green
        return button
    }()
    
    // New survey tile
    
    private let surveyTileUIView: UIView = {
        let tileView = UIView()
        tileView.backgroundColor = .white
        tileView.layer.cornerRadius = 5
        tileView.layer.masksToBounds = true
        return tileView
    }()
    
    private let surveyTile: UIButton = {
        let tileBtn = UIButton()
        tileBtn.backgroundColor = .white
        tileBtn.layer.cornerRadius = 5
        tileBtn.layer.masksToBounds = true
        tileBtn.addTarget(self, action: #selector(showNewSurvey), for: .touchUpInside)
        return tileBtn
    }()
    
    private let surveyTileLabel: UILabel = {
        let label = UILabel()
        label.text = "New Survey"
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textColor = UIColor.black
        //label.backgroundColor = .red
        return label
    }()
    
    private let surveyTileButton: UIButton = {
        let button = UIButton(type: .custom)
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: boldConfig), for: .normal)
        //button.backgroundColor = .green
        button.addTarget(self, action: #selector(showNewSurvey), for: .touchUpInside)
        return button
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
        lbl.text = "0"
        lbl.font = UIFont.systemFont(ofSize: 46)
        return lbl
    }()
    
    private lazy var temperatureTile: UIView = {
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
        let nav = UINavigationController(rootViewController: SafeActionsViewController())
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)

    }
    
    @objc func showNewSurvey() {
        let vc = SurveyViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func handleTempUpdate() {
        guard let temp = tempTF.text else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        self.view.endEditing(true)
        
        let values = [
            "temperature": temp
        ] as [String : Any]
        
        self.uploadUserTemperature(uid: currentUid, values: values)
        tempTF.text = ""
    }
    
    // MARK: - API
    
    func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.shared.fetchUserData(uid: currentUid) { (user) in
            self.user = user
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
        
        scrollView.addSubview(notificationsTile)
        notificationsTile.anchor(top: scrollView.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)
        
        scrollView.addSubview(notificationsTileLabel)
        notificationsTileLabel.anchor(top: notificationsTile.topAnchor, left: notificationsTile.leftAnchor, paddingLeft: 25)
        notificationsTileLabel.centerY(inView: notificationsTile)
        
        scrollView.addSubview(notificationsTileButton)
        notificationsTileButton.anchor(top: notificationsTile.topAnchor, right: notificationsTile.rightAnchor, width: 60)
        notificationsTileButton.centerY(inView: notificationsTile)
        
        // survey tile
        
        scrollView.addSubview(surveyTile)
        surveyTile.anchor(top: notificationsTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)

        scrollView.addSubview(surveyTileLabel)
        surveyTileLabel.anchor(top: surveyTile.topAnchor, left: surveyTile.leftAnchor, paddingLeft: 25)
        surveyTileLabel.centerY(inView: surveyTile)

        scrollView.addSubview(surveyTileButton)
        surveyTileButton.anchor(top: surveyTile.topAnchor, right: surveyTile.rightAnchor, width: 60)
        surveyTileButton.centerY(inView: surveyTile)
        
        scrollView.addSubview(temperatureTile)
        temperatureTile.anchor(top: surveyTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16, height: 300)
    }
    
    func configNavBar() {
        //navigationController?.navigationBar.barTintColor = .lightGray
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    func uploadUserTemperature(uid: String, values: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
            //handle error
            //print("user here! \(ref)")
            if error == nil {
                print("No error")
                self.tempLbl.text = values.first?.value as? String
            }
        }
    }
    
}
