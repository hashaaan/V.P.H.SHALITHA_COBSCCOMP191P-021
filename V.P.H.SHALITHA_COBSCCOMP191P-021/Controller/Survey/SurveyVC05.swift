//
//  SurveyVC05.swift
//  V.P.H.SHALITHA_COBSCCOMP191P-021
//
//  Created by HASHAN on 9/19/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit
import FirebaseAuth

class SurveyVC05: UIViewController {

    var result: Int!

    private let pageLbl: UILabel = {
        let label = UILabel()
        label.text = "(5 out of 5)"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    let levelLbl: UILabel = {
        let label = UILabel()
        label.text = "LOW"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
     
    private lazy var mainTile: UIView = {
        let tile = UIView()
        tile.backgroundColor = .white
        
        tile.addSubview(pageLbl)
        pageLbl.anchor(top: tile.topAnchor, paddingTop: 40)
        pageLbl.centerX(inView: tile)
        
        let title = UILabel()
        title.text="Survey Result"
        title.textColor = .darkGray
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 42)
        title.adjustsFontSizeToFitWidth = true
        tile.addSubview(title)
        title.anchor(top: pageLbl.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingRight: 20)
        
        let resultLbl = UILabel()
        resultLbl.text = "\(result!) / 4"
        resultLbl.textColor = .black
        resultLbl.textAlignment = .center
        resultLbl.adjustsFontSizeToFitWidth = true
        resultLbl.font = UIFont.boldSystemFont(ofSize: 24)
        tile.addSubview(resultLbl)
        resultLbl.anchor(top: title.bottomAnchor, paddingTop: 40, width: 100)
        resultLbl.centerX(inView: tile)
        
        let levelTitle = UILabel()
        levelTitle.text = "Possible Risk Level of COVID-19"
        levelTitle.textColor = .gray
        levelTitle.textAlignment = .center
        levelTitle.font = UIFont.systemFont(ofSize: 16)
        levelTitle.adjustsFontSizeToFitWidth = true
        tile.addSubview(levelTitle)
        levelTitle.anchor(top: resultLbl.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 60, paddingLeft: 20, paddingRight: 20)
        levelTitle.centerX(inView: tile)
        
        tile.addSubview(levelLbl)
        levelLbl.anchor(top: levelTitle.bottomAnchor, paddingTop: 40, width: 200)
        levelLbl.centerX(inView: tile)
        
        let backBtn = UIButton()
        backBtn.setTitle("Go Back", for: .normal)
        backBtn.setTitleColor(.white, for: .normal)
        backBtn.backgroundColor = .black
        backBtn.layer.cornerRadius = 5
        backBtn.clipsToBounds = true
        backBtn.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        tile.addSubview(backBtn)
        backBtn.anchor(top: levelLbl.bottomAnchor, paddingTop: 60, width: 120, height: 40)
        backBtn.centerX(inView: tile)

        return tile
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.surveyResultUpdate()
    }
     
    func configUI() {
        view.backgroundColor = .white
        view.addSubview(mainTile)
        mainTile.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        self.showRating()
    }
    
    func showRating() {
        guard let result = result else { return }
        var rating = ""
        var color = UIColor.black
        
        if result == 0 {
            rating = "VERY LOW"
            color = UIColor.green
        }
        else if result == 1 {
            rating = "LOW"
            color = UIColor.darkGray
        }
        else if result == 2 {
            rating = "MEDIUM"
            color = UIColor.yellow
        }
        else if result == 3 {
            rating = "HIGH"
            color = UIColor.orange
        }
        else if result == 4 {
            rating = "VERY HIGH"
            color = UIColor.red
        }
        levelLbl.text = "\(rating)"
        levelLbl.textColor = color
    }
    
    func surveyResultUpdate() {
        guard let result = result else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let values = [
            "surveyResult": result,
            "surveyDate": [".sv": "timestamp"]
        ] as [String : Any]
        
        self.uploadSurveyResult(uid: currentUid, values: values)
    }
    
    func uploadSurveyResult(uid: String, values: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
            if error == nil {
                print("No error")
            }
        }
    }
    
    @objc func handleGoBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
