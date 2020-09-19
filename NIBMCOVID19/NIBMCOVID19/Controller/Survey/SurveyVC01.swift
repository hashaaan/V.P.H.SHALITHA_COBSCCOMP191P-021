//
//  SurveyVC01.swift
//  V.P.H.SHALITHA_COBSCCOMP191P-021
//
//  Created by HASHAN on 9/18/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit

class SurveyVC01: UIViewController {
    
    private let pageLbl: UILabel = {
        let label = UILabel()
        label.text = "(1 out of 5)"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var mainTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .white
        
        tile.addSubview(pageLbl)
        pageLbl.anchor(top: tile.topAnchor, paddingTop: 40)
        pageLbl.centerX(inView: tile)
        
        let closeBtn = UIButton()
        closeBtn.setTitle("close", for: .normal)
        closeBtn.setTitleColor(.systemTeal, for: .normal)
        closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        closeBtn.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        tile.addSubview(closeBtn)
        closeBtn.anchor(top: tile.topAnchor, right: tile.rightAnchor, paddingTop: 10, paddingRight: 20)
        
        let imgTile = UIView()
        //imgTile.backgroundColor = .green
        tile.addSubview(imgTile)
        imgTile.anchor(top: pageLbl.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 10, height: 400)
        
        let image = UIImageView()
        image.image = UIImage(named: "SQ01")
        imgTile.addSubview(image)
        image.anchor(width: 350, height: 263)
        image.centerX(inView: imgTile)
        image.centerY(inView: imgTile)
        
        let question = UILabel()
        question.text = "Are you having any symptoms above?"
        question.font = UIFont(name: "Avenir-Medium", size: 18)
        //question.adjustsFontSizeToFitWidth = true
        question.numberOfLines = 2
        question.textAlignment = .center
        tile.addSubview(question)
        question.anchor(top: imgTile.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        //question.centerX(inView: tile)
        
        let btnYes = UIButton()
        btnYes.setTitle("YES", for: .normal)
        btnYes.setTitleColor(.black, for: .normal)
        btnYes.titleLabel?.font = UIFont(name: "Avenir-Black", size: 14)
        btnYes.addTextSpacing(2)
        btnYes.addTarget(self, action: #selector(handleYes), for: .touchUpInside)
        //btnYes.backgroundColor = .orange
        
        let btnNo = UIButton()
        btnNo.setTitle("NOPE", for: .normal)
        btnNo.setTitleColor(.black, for: .normal)
        btnNo.titleLabel?.font = UIFont(name: "Avenir-Black", size: 14)
        btnNo.addTextSpacing(2)
        btnNo.addTarget(self, action: #selector(handleNo), for: .touchUpInside)
        //btnNo.backgroundColor = .green
        
        let stack = UIStackView(arrangedSubviews: [btnYes, btnNo])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 0
        tile.addSubview(stack)
        stack.anchor(left: tile.leftAnchor, bottom: tile.bottomAnchor, right: tile.rightAnchor, paddingBottom: 20, height: 50)
        
        let separator = UIView()
        separator.backgroundColor = .lightGray
        tile.addSubview(separator)
        separator.anchor(bottom: stack.topAnchor, width: 110, height: 2)
        separator.centerX(inView: tile)
        
        return tile
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    func configUI() {
        view.backgroundColor = .white
        view.addSubview(mainTile)
        mainTile.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    @objc func handleClose() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func handleYes() {
        let vc = SurveyVC02()
        vc.result = 1
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleNo() {
        let vc = SurveyVC02()
        vc.result = 0
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
