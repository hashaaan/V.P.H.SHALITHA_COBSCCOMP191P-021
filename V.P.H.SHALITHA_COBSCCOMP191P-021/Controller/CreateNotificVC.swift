//
//  CreateNotificVC.swift
//  V.P.H.SHALITHA_COBSCCOMP191P-021
//
//  Created by HASHAN on 9/17/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        self.configUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleGoBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Helper Functions
    
    func configUI() {
        view.backgroundColor = .systemGray6
        configNavBar()
        view.addSubview(topNav)
        topNav.anchor(top: safeArea.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: view.bounds.height * 0.1)
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }

}
