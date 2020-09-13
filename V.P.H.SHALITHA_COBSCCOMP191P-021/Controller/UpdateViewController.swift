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
        return button
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
