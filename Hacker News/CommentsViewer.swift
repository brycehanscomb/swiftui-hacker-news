//
//  CommentsViewer.swift
//  Hacker News
//
//  Created by Bryce Hanscomb on 20/4/20.
//  Copyright © 2020 Bryce Hanscomb. All rights reserved.
//

import SwiftUI

struct CommentsViewer: View {
    public let storyId: Int
    
    @State var title: String = ""
    
    var body: some View {
        VStack {
            WebView(title: self.$title, url: URL(string: "https://news.ycombinator.com/item?id=\(self.storyId)")!)
        }
    }
}

struct CommentsViewer_Previews: PreviewProvider {
    static var previews: some View {
        CommentsViewer(storyId: 22862053)
    }
}
