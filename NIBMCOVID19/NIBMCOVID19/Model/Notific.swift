//
//  Notific.swift
//  V.P.H.SHALITHA_COBSCCOMP191P-021
//
//  Created by HASHAN on 9/18/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

struct Notific {
    let id: String
    let title: String
    let description: String
    let date: Int
    
    init(id: String, dictionary: [String: Any]) {
        self.id = id
        self.title = dictionary["title"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.date = dictionary["email"] as? Int ?? 0
    }
}
