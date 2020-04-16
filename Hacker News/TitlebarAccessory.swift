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
    var body: some View {
        HStack(alignment: .top) {
            Button(action: { return }) {
                Text("Show Feed")
            }
            Spacer()
            Button(action: { return }) {
                Text("Show Comments")
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(7)
    }
}

struct TitlebarAccessory_Previews: PreviewProvider {
    static var previews: some View {
        TitlebarAccessory().previewLayout(.fixed(width: 400, height: 40))
    }
}
