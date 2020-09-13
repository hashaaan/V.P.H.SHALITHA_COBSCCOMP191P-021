//
//  TestTableViewController.swift
//  NIBM COVID19
//
//  Created by HASHAN on 9/13/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit

class TestTableView: UITableView,  UITableViewDelegate, UITableViewDataSource {
    var characters = ["Link", "Zelda", "Ganondorf", "Midna"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = characters[indexPath.row]
        return cell
    }
}
