//
//  base.swift
//  px
//
//  Created by Anthony Kiniyalocts on 1/17/18.
//  Copyright © 2018 Anthony Kiniyalocts. All rights reserved.
//

import Foundation

protocol HasViewModel {
    func initView()
    func initViewModel()
}
protocol NetworkRequest {
    func didFail(error:Error)
}
