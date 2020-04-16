//
//  WebView.swift
//  Hacker News
//
//  Created by Bryce Hanscomb on 15/4/20.
//  Copyright © 2020 Bryce Hanscomb. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    @Binding var title: String
    var url: URL
    var loadStatusChanged: ((Bool, Error?) -> Void)? = nil
    
    func makeCoordinator() -> WebView.Coordinator {
        Coordinator(self)
    }
  
    func makeNSView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.navigationDelegate = context.coordinator
        view.load(URLRequest(url: url))
        return view
    }
  
    func updateNSView(_ uiView: WKWebView, context: Context) {
        if (self.url != uiView.url) {
            uiView.load(URLRequest(url: self.url))
        }
        // you can access environment via context.environment here
        // Note that this method will be called A LOT
    }
  
    func onLoadStatusChanged(perform: ((Bool, Error?) -> Void)?) -> some View {
        var copy = self
        copy.loadStatusChanged = perform
        return copy
    }
  
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView
  
        init(_ parent: WebView) {
            self.parent = parent
        }
  
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.loadStatusChanged?(true, nil)
        }
  
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.title = webView.title ?? ""
            parent.loadStatusChanged?(false, nil)
        }
  
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.loadStatusChanged?(false, error)
        }
    }
}
