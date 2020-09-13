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
        label.textColor = .black
        return label
    }()
    
    private let profileTile: UIButton = {
        let tile = UIButton()
        tile.backgroundColor = .white
        
        let title = UILabel()
        title.text = "Profile"
        title.textColor = .darkGray
        tile.addSubview(title)
        //title.backgroundColor = .green
        title.anchor(top: tile.topAnchor, left: tile.leftAnchor, bottom: tile.bottomAnchor, paddingLeft: 20)
        title.centerY(inView: tile)
        
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "chevron.right")
        //arrow.backgroundColor = .green
        arrow.layer.masksToBounds = true
        tile.addSubview(arrow)
        arrow.anchor(right: tile.rightAnchor, paddingRight: 20, width: 14, height: 24)
        arrow.centerY(inView: tile)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        tile.addSubview(separatorView)
        separatorView.anchor(left: tile.leftAnchor, bottom: tile.bottomAnchor, right: tile.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
        
        tile.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        
        return tile
    }()
    
    private let contactTile: UIButton = {
        let tile = UIButton()
        tile.backgroundColor = .white
        
        let title = UILabel()
        title.text = "Contact Us / About Us"
        title.textColor = .darkGray
        tile.addSubview(title)
        //title.backgroundColor = .green
        title.anchor(top: tile.topAnchor, left: tile.leftAnchor, bottom: tile.bottomAnchor, paddingLeft: 20)
        title.centerY(inView: tile)
        
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "chevron.right")
        //arrow.backgroundColor = .green
        arrow.layer.masksToBounds = true
        tile.addSubview(arrow)
        arrow.anchor(right: tile.rightAnchor, paddingRight: 20, width: 14, height: 24)
        arrow.centerY(inView: tile)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        tile.addSubview(separatorView)
        separatorView.anchor(left: tile.leftAnchor, bottom: tile.bottomAnchor, right: tile.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
        
        tile.addTarget(self, action: #selector(showContact), for: .touchUpInside)
        
        return tile
    }()
    
    private let shareTile: UIButton = {
        let tile = UIButton()
        tile.backgroundColor = .white
        
        let title = UILabel()
        title.text = "Share with friend"
        title.textColor = .systemBlue
        tile.addSubview(title)
        //title.backgroundColor = .green
        title.anchor(top: tile.topAnchor, left: tile.leftAnchor, bottom: tile.bottomAnchor, paddingLeft: 20)
        title.centerY(inView: tile)
        
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "chevron.right")
        //arrow.backgroundColor = .green
        arrow.layer.masksToBounds = true
        tile.addSubview(arrow)
        arrow.anchor(right: tile.rightAnchor, paddingRight: 20, width: 14, height: 24)
        arrow.centerY(inView: tile)
                
        tile.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        
        return tile
    }()
    
    private let blankView: UIView = {
        let blank = UIView()
        blank.backgroundColor = .white
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        blank.addSubview(separatorView)
        separatorView.anchor(left: blank.leftAnchor, bottom: blank.bottomAnchor, right: blank.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
        
        return blank
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
    
    @objc func showProfile() {
       print("Profile!")
    }
    
    @objc func showContact() {
       print("Contact Us!")
    }
    
    @objc func handleShare() {
       print("Share!")
    }
    
    // MARK: - Helper Function

    func configUI() {
        configNavBar()
        
        view.backgroundColor = .systemGray6
        
        view.addSubview(titleLbl)
        titleLbl.anchor(top: safeArea.topAnchor, paddingTop: 20)
        titleLbl.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [profileTile, contactTile, shareTile])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 0
        
        view.addSubview(stack)
        stack.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, height: 210)
        
        view.addSubview(logoutButton)
        logoutButton.anchor(left: view.leftAnchor, bottom: safeArea.bottomAnchor, right: view.rightAnchor, height: 60)
        
        view.addSubview(blankView)
        blankView.anchor(top: stack.bottomAnchor, left: view.leftAnchor, bottom: logoutButton.topAnchor, right: view.rightAnchor)
        
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
