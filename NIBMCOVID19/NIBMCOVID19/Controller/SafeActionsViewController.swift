//
//  SafeActionsViewController.swift
//  NIBM COVID19
//
//  Created by HASHAN on 9/3/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit

class SafeActionsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back_black"), for: .normal)
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        return button
    }()
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.text = "Safe Actions"
        label.font = UIFont(name: "Avenir-Light", size: 30)
        label.textColor = UIColor.black
        return label
    }()
    
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
        titleLbl.text = "Safe Actions"
        titleLbl.font = UIFont(name: "Avenir-Light", size: 26)
        titleLbl.textColor = .black
        titleLbl.adjustsFontSizeToFitWidth = true
        uv.addSubview(titleLbl)
        titleLbl.centerY(inView: uv)
        titleLbl.centerX(inView: uv)
        
        return uv
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        let screensize: CGRect = UIScreen.main.bounds
        sv.contentSize = CGSize(width: screensize.width - 2.0, height: screensize.height - 70)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .white
        return sv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    

    private func configUI() {
        configNavBar()
        
        // setup scrollview
        let screensize: CGRect = view.bounds
        let titles = ["Clean yourself", "Avoid Touching Your Face", "Keep the Distance Between", "Limit Physical contact with others"]
        let subTitles = ["When and How to Wash Your Hands", "When and How to Wash Your Hands", "When and How to Wash Your Hands", "When and How to Wash Your Hands"]
        let images = ["SFA01", "SFA02", "SFA03", "SFA04"]
        
        view.backgroundColor = .systemGray6
        view.addSubview(topNav)
        topNav.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 70)
        
        view.addSubview(scrollView)
        scrollView.anchor(top: topNav.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        for x in 0..<4 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * screensize.width, y: 0, width: screensize.width, height: screensize.height-titleLbl.frame.size.height))
            scrollView.addSubview(pageView)
            
            let imageTile = UIView()
            pageView.addSubview(imageTile)
            imageTile.anchor(top: pageView.topAnchor, left: pageView.leftAnchor, right: pageView.rightAnchor, height: 400)
            
            let imageView = UIImageView()
            imageView.image = UIImage(named: images[x])
            imageTile.addSubview(imageView)
            if x == 0 {
                imageView.anchor(width: 380, height: 355)
            } else {
                imageView.anchor(width: 380, height: 285)
            }
            imageView.centerX(inView: imageTile)
            imageView.centerY(inView: imageTile)
            
            let titleLbl = UILabel()
            titleLbl.text = titles[x]
            titleLbl.textAlignment = .center
            titleLbl.font = UIFont.boldSystemFont(ofSize: 24)
            titleLbl.adjustsFontSizeToFitWidth = true
            pageView.addSubview(titleLbl)
            titleLbl.anchor(top: imageTile.bottomAnchor, left: pageView.leftAnchor, right: pageView.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20)
            
            let subTitleLbl = UILabel()
            subTitleLbl.text = subTitles[x]
            subTitleLbl.textAlignment = .center
            subTitleLbl.font = UIFont.systemFont(ofSize: 14)
            subTitleLbl.textColor = .systemGray
            subTitleLbl.adjustsFontSizeToFitWidth = true
            pageView.addSubview(subTitleLbl)
            subTitleLbl.anchor(top: titleLbl.bottomAnchor, left: pageView.leftAnchor, right: pageView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 20)
            
            let button = UIButton(frame: CGRect(x:  10, y: pageView.frame.size.height-60, width: pageView.frame.size.width-20, height: 50))
            button.setTitle("NEXT", for: .normal)
            
            if(x == 2) {
               button.setTitle("DONE!", for: .normal)
            }
            
            button.setTitleColor(.gray, for: .normal)
            button.addTarget(self, action: #selector(handleTapNext(_:)), for: .touchUpInside)
            button.tag = x+1
            pageView.addSubview(button)
            //nextButton.anchor(bottom: pageView.bottomAnchor, paddingBottom: 30)
            //nextButton.centerX(inView: view)
        }
        
        scrollView.contentSize = CGSize(width: screensize.width * 4 , height: 0)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
         
    }
    
    func configNavBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    // MARK: - Selectors
    
    @objc func handleTapNext(_ button: UIButton) {
        guard button.tag < 3 else {
            // dismiss
            return
        }
        // scroll to next page
        scrollView.setContentOffset(CGPoint(x: view.bounds.width * CGFloat(button.tag), y: 0), animated: true)
    }
    
    @objc func handleGoBack() {
       navigationController?.popViewController(animated: true)
    }

}
