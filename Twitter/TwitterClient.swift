//
//  OAuthClientSettings.swift
//  Twitter
//
//  Created by Rocha, Luis on 4/15/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    let requestTokenPath = "oauth/request_token"
    let authorizePath = "oauth/authorize"
    let accessTokenPath = "oauth/access_token"
    
    static let sharedInstance = TwitterClient(
        baseURL: URL(string: "https://api.twitter.com/")!,
        consumerKey: "UxsBQS88KHmXJbfGutIwPeKyy",
        consumerSecret: "sZ7GXw5pQK0L3TRHZIa1t28QS85HquJJhsxumZBmSDLxkNZslA")
    
    func getAuthorizeUrl(success: @escaping (URL?) -> Void, failure: @escaping (Error?) -> Void) {
        deauthorize()
        
        fetchRequestToken(withPath: self.requestTokenPath, method: "GET", callbackURL: URL(string: "twitterdemo://oauth")!, scope: nil, success: { (requestToken) in
            if let token = requestToken?.token {
                let url = URL(string: "\(self.baseURL!.absoluteString)\(self.authorizePath)?oauth_token=\(token)")!
                success(url)
            } else {
                failure(NSError(domain: "Error featching request token.", code: 400, userInfo: nil))
            }
        }, failure: { (error) in
            failure(error)
        })
    }
}
