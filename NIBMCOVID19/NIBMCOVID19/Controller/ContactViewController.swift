//
//  ContactViewController.swift
//  NIBM COVID19
//
//  Created by HASHAN on 9/13/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    // MARK: - Properties
    
    var safeArea: UILayoutGuide!
    
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
        label.text = "Contact Us / About Us"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Avenir-Light", size: 26)
        label.textColor = .black
        return label
    }()
    
    private let mainTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .white
        
        let headOfficeLbl = UILabel()
        headOfficeLbl.text = "HEAD OFFICE"
        headOfficeLbl.adjustsFontSizeToFitWidth = true
        headOfficeLbl.font = UIFont.systemFont(ofSize: 18)
        headOfficeLbl.textAlignment = .center
        headOfficeLbl.textColor = .black
        
        tile.addSubview(headOfficeLbl)
        headOfficeLbl.anchor(top: tile.topAnchor, paddingTop: 40)
        headOfficeLbl.centerX(inView: tile)
        
        let phoneLbl = UILabel()
        phoneLbl.text = "Phone No : +94 117 321 000"
        phoneLbl.adjustsFontSizeToFitWidth = true
        phoneLbl.font = UIFont.systemFont(ofSize: 14)
        phoneLbl.textAlignment = .center
        phoneLbl.textColor = .black
        
        tile.addSubview(phoneLbl)
        phoneLbl.anchor(top: headOfficeLbl.bottomAnchor, paddingTop: 40)
        phoneLbl.centerX(inView: tile)
        
        let addrLbl = UILabel()
        addrLbl.text = "Address: 120/5 Vidya Mawatha, Colombo 07, Sri Lanka"
        addrLbl.numberOfLines = 2
        addrLbl.font = UIFont.systemFont(ofSize: 14)
        addrLbl.textAlignment = .center
        addrLbl.textColor = .black
        
        tile.addSubview(addrLbl)
        addrLbl.anchor(top: phoneLbl.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 40, paddingLeft: 50, paddingRight: 50)
        
        let aboutTitle = UILabel()
        aboutTitle.text = "ABOUT US"
        addrLbl.adjustsFontSizeToFitWidth = true
        addrLbl.font = UIFont.systemFont(ofSize: 18)
        addrLbl.textAlignment = .center
        addrLbl.textColor = .black
        
        tile.addSubview(aboutTitle)
        aboutTitle.anchor(top: addrLbl.bottomAnchor, paddingTop: 50)
        aboutTitle.centerX(inView: tile)
        
        let aboutDes = UILabel()
        aboutDes.text = "Address: 120/5 Vidya Mawatha, Colombo 07, Sri Lanka"
        aboutDes.numberOfLines = 6
        aboutDes.font = UIFont.systemFont(ofSize: 14)
        aboutDes.textAlignment = .center
        aboutDes.textColor = .black
        
        tile.addSubview(addrLbl)
        addrLbl.anchor(top: phoneLbl.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 40, paddingLeft: 50, paddingRight: 50)
        
        return tile
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        configUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleGoBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func configUI() {
        configNavBar()
        view.backgroundColor = .systemGray6
        view.addSubview(titleLbl)
        titleLbl.anchor(top: safeArea.topAnchor, paddingTop: 20)
        titleLbl.centerX(inView: view)
        view.addSubview(backButton)
        backButton.anchor(top: safeArea.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 38, height: 38)
        view.addSubview(mainTile)
        mainTile.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20)
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }

}
