//
//  TitlebarAccessory.swift
//  Hacker News
//
//  Created by Bryce Hanscomb on 15/4/20.
//  Copyright © 2020 Bryce Hanscomb. All rights reserved.
//

import SwiftUI

public struct CustomButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Color(NSColor.controlColor))
            .foregroundColor(Color(NSColor.textColor))
            .cornerRadius(4)
            
    }
}

struct TitlebarAccessory: View {
    public let currentUrl: String?
    
    @Binding public var shouldShowFeed: Bool
    @Binding public var shouldShowComments: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Button(action: {
                self.shouldShowFeed.toggle()
            }) {
                Text("Show Feed: \(self.shouldShowFeed ? "Yes" : "No")")
            }
            Spacer()
            if self.currentUrl != nil {
                Text(self.currentUrl!)
            }
            Spacer()
            Button(action: {
                self.shouldShowComments.toggle()
            }) {
                Text("Show Comments: \(self.shouldShowComments ? "Yes" : "No")")
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(7)
    }
}
