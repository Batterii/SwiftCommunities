//
//  RealmUtils.swift
//  Oddesy
//
//  Created by Anthony Kiniyalocts on 1/25/18.
//  Copyright © 2018 Anthony Kiniyalocts. All rights reserved.
//

import Foundation

public protocol RealmCollectionListener{
    func initial()
    func dispatachTableViewUpdates(deletions: [Int], insertions:[Int], modifications:[Int])
}
