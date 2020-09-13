//
//  SettingsViewController.swift
//  NIBM COVID19
//
//  Created by HASHAN on 9/12/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont(name: "Avenir-Light", size: 30)
        label.textColor = UIColor.black
        return label
    }()
    
    private let profileTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .white
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        tile.addSubview(separatorView)
        separatorView.anchor(left: tile.leftAnchor, bottom: tile.bottomAnchor, right: tile.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
        
        return tile
    }()
    
    private let contactTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .white
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        tile.addSubview(separatorView)
        separatorView.anchor(left: tile.leftAnchor, bottom: tile.bottomAnchor, right: tile.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
        
        return tile
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("LOGOUT", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    var safeArea: UILayoutGuide!
    var characters = ["Link", "Zelda", "Ganondorf", "Midna"]

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        configUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleLogout() {
       signOut()
    }
    
    // MARK: - Helper Function

    func configUI() {
        configNavBar()
        
        view.backgroundColor = .systemGray6
        
        view.addSubview(titleLbl)
        titleLbl.anchor(top: safeArea.topAnchor, paddingTop: 20)
        titleLbl.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [profileTile, contactTile])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 0
        
        view.addSubview(stack)
        stack.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, height: 180)
        
        view.addSubview(logoutButton)
        logoutButton.anchor(left: view.leftAnchor, bottom: safeArea.bottomAnchor, right: view.rightAnchor, height: 60)
        
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: AuthViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } catch {
            print("DEBUG: sign out error!")
        }
    }

}
