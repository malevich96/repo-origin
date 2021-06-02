//
//  WKWebView.swift
//  VK1_App
//
//  Created by Анатолий Левин on 21.04.2021.
//

import UIKit
import WebKit


class WKWebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!{
            didSet{
                webView.navigationDelegate = self
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       webView.navigationDelegate = self
        
        var urlComponents = URLComponents()
                
            urlComponents.scheme = "https"
                urlComponents.host = "oauth.vk.com"
                urlComponents.path = "/authorize"
                urlComponents.queryItems = [
                    URLQueryItem(name: "client_id", value: "7832741"),
                    URLQueryItem(name: "display", value: "mobile"),
                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                    URLQueryItem(name: "scope", value: "262150"),
                    URLQueryItem(name: "response_type", value: "token"),
                    URLQueryItem(name: "v", value: "5.68")
                ]
                
                 print(urlComponents.url!)
                let request = URLRequest(url: urlComponents.url!)
               
                webView.load(request)
    }
}

extension WKWebViewController {
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
            guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
                decisionHandler(.allow)
                return
            }
            
            let params = fragment
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .reduce([String: String]()) { result, param in
                    var dict = result
                    let key = param[0]
                    let value = param[1]
                    dict[key] = value
                    return dict
            }
            
            guard let accessToken = params["access_token"],
                let userId = params["user_id"] else {
                decisionHandler(.allow)
                return
            }
            
<<<<<<< Updated upstream:WKWebViewController.swift
            Session.instance.accessToken = accessToken
            Session.instance.userId = userId
=======
            VKSession.instance.accessToken = accessToken
            VKSession.instance.userId = userId
>>>>>>> Stashed changes:VK1_App/Network/WKWebViewController.swift
            
            print("token = " + params["access_token"]!)
            print("user = " + params["user_id"]!)
            
            self.performSegue(withIdentifier: "login", sender: self)
            decisionHandler(.cancel)
    }
 }
