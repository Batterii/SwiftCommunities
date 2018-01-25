//
//  Community.swift
//  Oddesy
//
//  Created by Anthony Kiniyalocts on 1/19/18.
//  Copyright © 2018 Anthony Kiniyalocts. All rights reserved.
//

import Foundation
struct IndexResponse: Codable {
    let community: Community
}

struct ActiveSsoEndpoint: Codable {
    let displayName, description, url: String
    let textColor: String?
    let bgColor : String?
    let iconName : String?
    let imageURL : String?
    let providerName: String?
    let providerType: String

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case description, url
        case textColor = "text_color"
        case bgColor = "bg_color"
        case iconName = "icon_name"
        case imageURL = "image_url"
        case providerName = "provider_name"
        case providerType = "provider_type"
    }
}
