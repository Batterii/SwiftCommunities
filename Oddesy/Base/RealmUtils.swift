//
//  RealmUtils.swift
//  Oddesy
//
//  Created by Anthony Kiniyalocts on 1/25/18.
//  Copyright © 2018 Anthony Kiniyalocts. All rights reserved.
//

import Foundation
import UIKit

public protocol RealmCollectionListener{
    var tableview : UITableView{get}
    func initial()
    func dispatachTableViewUpdates(deletions: [Int], insertions:[Int], modifications:[Int])
}

extension RealmCollectionListener{
    func initial() {
        tableview.reloadData()
    }

    func dispatachTableViewUpdates(deletions: [Int], insertions: [Int], modifications: [Int]) {

        self.tableview.beginUpdates()

        self.tableview.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                with: .automatic)
        self.tableview.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                with: .automatic)
        self.tableview.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                with: .automatic)
        self.tableview.endUpdates()
    }
}
