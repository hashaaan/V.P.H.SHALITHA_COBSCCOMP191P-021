//
//  ProfileViewController.swift
//  NIBM COVID19
//
//  Created by HASHAN on 9/12/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    // MARK: - Properties
    
    var safeArea: UILayoutGuide!
    
    var user: User? {
        didSet { titleLbl.text = "\(user!.firstName) \(user!.lastName)" }
    }
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        let boldConfig = UIImage.SymbolConfiguration(pointSize: .zero, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "chevron.left", withConfiguration: boldConfig), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        return button
    }()
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.text = "Update Profile"
        label.font = UIFont(name: "Avenir-Light", size: 26)
        label.textColor = .black
        return label
    }()
    
    private let blankView: UIView = {
        let blank = UIView()
        blank.backgroundColor = .white
        return blank
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        fetchUserData()
        configUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleGoBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func configUI() {
        configNavBar()
        view.backgroundColor = .white
        view.addSubview(titleLbl)
        titleLbl.anchor(top: safeArea.topAnchor, paddingTop: 20)
        titleLbl.centerX(inView: view)
        view.addSubview(backButton)
        backButton.anchor(top: safeArea.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 38, height: 38)
        view.addSubview(blankView)
        blankView.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, bottom: safeArea.bottomAnchor, right: view.rightAnchor, paddingTop: 20)
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    // MARK: - API
    
    func fetchUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Service.shared.fetchUserData(uid: currentUid) { (user) in
            self.user = user
        }
    }


}
