//
//  TitlebarAccessory.swift
//  Hacker News
//
//  Created by Bryce Hanscomb on 15/4/20.
//  Copyright © 2020 Bryce Hanscomb. All rights reserved.
//

import SwiftUI

struct TitlebarAccessory: View {
    var body: some View {
        HStack(alignment: .top) {
            Button(action: { return }) {
                Image(nsImage: NSImage(named: NSImage.touchBarSidebarTemplateName)!)
            }.buttonStyle(PlainButtonStyle())
        }.background(Color.green)
    }
}

struct TitlebarAccessory_Previews: PreviewProvider {
    static var previews: some View {
        TitlebarAccessory().previewLayout(.fixed(width: 400, height: 40))
    }
}
