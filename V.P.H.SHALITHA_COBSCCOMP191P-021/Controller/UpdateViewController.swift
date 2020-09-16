//
//  UpdateViewController.swift
//  NIBM COVID19
//
//  Created by HASHAN on 9/4/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {
    
    // MARK: - Properties
    
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
    
    private let temperatureTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .white
        tile.layer.cornerRadius = 5
        tile.layer.masksToBounds = true
        
        let tempLbl = UILabel()
        tempLbl.text = "36.1"
        tempLbl.font = UIFont.systemFont(ofSize: 46)
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
        
        let tempInput = UITextField()
        tempInput.borderStyle = .roundedRect
        tempInput.layer.borderColor = UIColor.black.cgColor
        tempInput.layer.borderWidth = 0.5
        tempInput.layer.cornerRadius = 5.0
        tempInput.layer.masksToBounds = true
        tile.addSubview(tempInput)
        tempInput.anchor(top: timeAgo.bottomAnchor, paddingTop: 40, width: 100)
        tempInput.centerX(inView: tile)
        
        let tempBtn = UIButton()
        tempBtn.setTitle("UPDATE", for: .normal)
        tempBtn.setTitleColor(.black, for: .normal)
        tempBtn.layer.borderColor = UIColor.black.cgColor
        tempBtn.layer.borderWidth = 0.5
        tempBtn.layer.cornerRadius = 5.0
        tempBtn.layer.masksToBounds = true
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tempBtn.addTextSpacing(2)
        tile.addSubview(tempBtn)
        tempBtn.anchor(top: tempInput.bottomAnchor, paddingTop: 35, width: 120, height: 40)
        tempBtn.centerX(inView: tile)
        
        return tile
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI() {
        configNavBar()
        view.backgroundColor = .systemGray6
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        titleLabel.centerX(inView: view)
        
        view.addSubview(notificationsTile)
        notificationsTile.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)
        
        view.addSubview(notificationsTileLabel)
        notificationsTileLabel.anchor(top: notificationsTile.topAnchor, left: notificationsTile.leftAnchor, paddingLeft: 25)
        notificationsTileLabel.centerY(inView: notificationsTile)
        
        view.addSubview(notificationsTileButton)
        notificationsTileButton.anchor(top: notificationsTile.topAnchor, right: notificationsTile.rightAnchor, width: 60)
        notificationsTileButton.centerY(inView: notificationsTile)
        
        // survey tile
        
        view.addSubview(surveyTile)
        surveyTile.anchor(top: notificationsTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 70)

        view.addSubview(surveyTileLabel)
        surveyTileLabel.anchor(top: surveyTile.topAnchor, left: surveyTile.leftAnchor, paddingLeft: 25)
        surveyTileLabel.centerY(inView: surveyTile)

        view.addSubview(surveyTileButton)
        surveyTileButton.anchor(top: surveyTile.topAnchor, right: surveyTile.rightAnchor, width: 60)
        surveyTileButton.centerY(inView: surveyTile)
        
        view.addSubview(temperatureTile)
        temperatureTile.anchor(top: surveyTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16, height: 300)
    }
    
    func configNavBar() {
        //navigationController?.navigationBar.barTintColor = .lightGray
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    // MARK: - Selectors
    
    @objc func showNotifications() {
        let nav = UINavigationController(rootViewController: SafeActionsViewController())
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)

    }
    
    @objc func showNewSurvey() {
//        let nav = UINavigationController(rootViewController: SurveyViewController())
//        nav.modalPresentationStyle = .fullScreen
//        self.present(nav, animated: true, completion: nil)
        let vc = SurveyViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}
