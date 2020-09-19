//
//  SurveyVC04.swift
//  V.P.H.SHALITHA_COBSCCOMP191P-021
//
//  Created by HASHAN on 9/19/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit

class SurveyVC04: UIViewController {
    
    var result: Int!

    private let pageLbl: UILabel = {
        let label = UILabel()
        label.text = "(4 out of 5)"
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
        
        let imgTile = UIView()
        //imgTile.backgroundColor = .green
        tile.addSubview(imgTile)
        imgTile.anchor(top: pageLbl.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 10, height: 400)
        
        let image = UIImageView()
        image.image = UIImage(named: "SQ02")
        imgTile.addSubview(image)
        image.anchor(top: imgTile.topAnchor, paddingTop: 20, width: 280, height: 200)
        image.centerX(inView: imgTile)
        
        let imgLbl = UILabel()
        imgLbl.text = "AVOID CONTACT WITH SICK PEOPLE"
        imgLbl.font = UIFont(name: "Avenir-Medium", size: 18)
        imgLbl.textColor = .darkGray
        imgLbl.textAlignment = .center
        imgLbl.numberOfLines = 2
        imgTile.addSubview(imgLbl)
        imgLbl.anchor(top: image.bottomAnchor, paddingTop: 10, width: 200)
        imgLbl.centerX(inView: imgTile)

        let question = UILabel()
        question.text = "Have you been interact with any sick person recently?"
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
     
    @objc func handleYes() {
        let vc = SurveyVC05()
        vc.result = self.result! + 1
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
    @objc func handleNo() {
        let vc = SurveyVC05()
        vc.result = self.result!
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
