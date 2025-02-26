//
//  SimpleWebView.swift
//  LiveScribe
//
//  Created by Christian Skorobogatow on 24/2/25.
//

import SwiftUI
import WebKit

struct SimpleWebView: NSViewRepresentable {
    var content: String
    
    func makeNSView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateNSView(_ webView: WKWebView, context: Context) {
        webView.loadHTMLString(content, baseURL: nil)
    }
}

#Preview {
    SimpleWebView(content: "Testing")
}
