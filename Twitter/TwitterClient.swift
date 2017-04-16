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
        consumerKey: "consumer_key",
        consumerSecret: "consumer_secret")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        
        fetchRequestToken(withPath: self.requestTokenPath, method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            let url = URL(string: "\(self.baseURL!.absoluteString)\(self.authorizePath)?oauth_token=\(requestToken?.token ?? "")")!
            print("login; status=ok; url=\(url.absoluteString)")
            UIApplication.shared.open(url)
        }) { (error: Error?) in
            print("login; status=failed; error=\(error?.localizedDescription ?? "")")
        }
    }
    
    func handleOpenUrl(open url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken) in
            let requestToken = BDBOAuth1Credential(queryString: url.query)

            self.loginSuccess?()
            
//            currentAccount(success: { (user: User) in
//                print(user.screenname!)
//            }, failure: { (error: Error) in
//                // error
//            })
//            
//            homeTimeLine(success: { (tweets: [Tweet]) in
//                for tweet in tweets {
//                    print(tweet.text!)
//                }
//            }, failure: { (error: Error) in
//                // error
//            })
            
        }, failure: { (error: Error!) in
            print("error\(error.localizedDescription)")
            self.loginFailure?(error)
        })
        
    }
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
            let data = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: data)
            print("homeTimeLine; status=ok; total=\(tweets.count)")
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("homeTimeLine; status=failed; error=\(error.localizedDescription)")
            failure(error)
        })
    }
    
    func currentAccount(success: @escaping (User)->(), failure: @escaping (Error)->()) {
        get("1.1/account/verify_credentials.json", parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
            let data = response as! NSDictionary
            let user = User(dictionary: data)
            print("currentAccount; status=ok; screenname=\((user.screenname) ?? "")")
            success(user)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("currentAccount; status=failed; error=\(error.localizedDescription)")
            failure(error)
        })
    }
}
