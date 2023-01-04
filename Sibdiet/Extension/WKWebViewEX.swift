//
//  WKWebViewEX.swift
//  Sibdiet
//
//  Created by Me on 9/2/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import WebKit

extension URL{
    init?(_ string: String){
        self.init(string: string)
    }
}

extension URLRequest{
    init(_ url: URL) {
        self.init(url: url)
    }
}

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
