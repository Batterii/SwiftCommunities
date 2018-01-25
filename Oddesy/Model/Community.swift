//
//  Community.swift
//  Oddesy
//
//  Created by Anthony Kiniyalocts on 1/25/18.
//  Copyright © 2018 Anthony Kiniyalocts. All rights reserved.
//

import Foundation
import RealmSwift

class Community : Object, Codable{
    @objc dynamic var name = ""
    
    @objc dynamic var bckey = ""
    
    @objc dynamic var logoPicPath = ""
    
    @objc dynamic var logos : Logos?
    
    override static func primaryKey() -> String? {
        return "bckey"
    }
    
    enum CodingKeys: String, CodingKey {
        case logoPicPath = "logo_pic_path"
        case name
        case logos
        case bckey
    }
}
class Logos : Object, Codable{
    @objc dynamic var banner : Banner?
    
    @objc dynamic var primary : Banner?
}
class Banner : Object, Codable{
    @objc dynamic var avgColor: String? = nil
    @objc dynamic var parentKind : String? = nil
    @objc dynamic var servingURL: String? = nil
    @objc dynamic var name: String? = nil
    @objc dynamic var kind: String? = nil
    @objc dynamic var isDefault = false
    @objc dynamic var aspectRatio: Double = 0.0

    
    enum CodingKeys: String, CodingKey {
        case avgColor = "avg_color"
        case parentKind = "parent_kind"
        case servingURL = "serving_url"
        case name
        case isDefault = "is_default"
        case aspectRatio = "aspect_ratio"
    }
    
}

