//
//  User.swift
//  Twitter
//
//  Created by Luis Rocha on 4/15/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var screenname: String?
    var tagline: String?
    var profileUrl: URL?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
    }
}
