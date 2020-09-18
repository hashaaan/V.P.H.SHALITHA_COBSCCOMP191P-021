//
//  CreateNotificVC.swift
//  V.P.H.SHALITHA_COBSCCOMP191P-021
//
//  Created by HASHAN on 9/17/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateNotificVC: UIViewController {
    
    // MARK: - Properties
    
    var safeArea: UILayoutGuide!
    
    private let topNav: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGray6
        
        let backBtn = UIButton()
        let boldConfig = UIImage.SymbolConfiguration(pointSize: .zero, weight: .bold, scale: .large)
        backBtn.setImage(UIImage(systemName: "chevron.left", withConfiguration: boldConfig), for: .normal)
        backBtn.tintColor = .black
        backBtn.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        uv.addSubview(backBtn)
        backBtn.anchor(left: uv.leftAnchor, paddingLeft: 16, width: 38, height: 38)
        backBtn.centerY(inView: uv)
        
        let titleLbl = UILabel()
        titleLbl.text = "Create Notifications"
        titleLbl.font = UIFont(name: "Avenir-Light", size: 26)
        titleLbl.textColor = .black
        titleLbl.adjustsFontSizeToFitWidth = true
        uv.addSubview(titleLbl)
        titleLbl.centerY(inView: uv)
        titleLbl.centerX(inView: uv)
        
        return uv
    }()
    
    private let titleTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Notification Title"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .sentences
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 5.0
        tf.layer.masksToBounds = true
        return tf
    }()
    
    private let descriptionTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.placeholder = "Description"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .sentences
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 5.0
        tf.layer.masksToBounds = true
        return tf
    }()
    
    private let createBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("CREATE", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 5.0
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTextSpacing(2)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.addTarget(self, action: #selector(handleCreate), for: .touchUpInside)
        return btn
    }()
    
    private lazy var formTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [titleTF, descriptionTF, createBtn])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 30

        tile.addSubview(stack)
        stack.anchor(top: tile.topAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        return tile
    }()
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        self.configUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleGoBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func handleCreate() {
        guard let title = titleTF.text else { return }
        guard let description = descriptionTF.text else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        if title.isEmpty {
            let alert = UIAlertController(title: "Title is Required!", message: "Please enter notification title", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        } else if description.isEmpty  {
            let alert = UIAlertController(title: "Description is Required!", message: "Please enter notification title", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        self.view.endEditing(true)
        
        let values = [
            "title": title,
            "description": description,
            "date": [".sv": "timestamp"]
        ] as [String : Any]
        
        self.uploadNotificationData(uid: currentUid, values: values)
        self.titleTF.text = ""
        self.descriptionTF.text = ""
        
    }
    
    // MARK: - Helper Functions
    
    func configUI() {
        view.backgroundColor = .systemGray6
        configNavBar()
        view.addSubview(topNav)
        topNav.anchor(top: safeArea.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: view.bounds.height * 0.1)
        view.addSubview(formTile)
        formTile.anchor(top: topNav.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    func uploadNotificationData(uid: String, values: [String: Any]) {
        
        REF_NOTIFICATIONS.childByAutoId().setValue(values) { (error, ref) in
                
            if let error = error {
                print("Faild to create notification \(error)")
                return
            }
            
            let alert = UIAlertController(title: "Success!", message: "Notification created successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
        
    }

}
