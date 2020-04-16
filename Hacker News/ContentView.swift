//
//  ContentView.swift
//  Hacker News
//
//  Created by Bryce Hanscomb on 14/4/20.
//  Copyright © 2020 Bryce Hanscomb. All rights reserved.
//

import SwiftUI


struct StoryLink: View {
    public let storyId: Int
    public let isActive: Bool
    @Binding public var storyItem: StoryItem
    
    @State private var loading: Bool = false
    
    @State private var data: Optional<StoryItem> = nil
    
    var body: some View {
        VStack(spacing: 0) {
            Text(self.getLabel()).onAppear {
                self.fetchStory()
            }.frame(maxWidth: .infinity, alignment: .topLeading).padding(15)
            Divider()
        }.background(self.isActive ? Color(NSColor.selectedContentBackgroundColor) : Color(NSColor.textBackgroundColor)).onTapGesture {
            self.storyItem = self.data!
        }
    }
    
    private func getLabel() -> String {
        if self.loading {
            return "Loading..."
        }
        
        if let story = self.data {
            return story.title
        }
        
        return String("Story \(self.storyId)")
    }
    
    private func fetchStory() {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(self.storyId).json")!

        self.loading = true
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                print(String(error.debugDescription))
                self.loading = false
                return
            }
                        
            do {
                let item: StoryItem = try JSONDecoder().decode(StoryItem.self, from: data)
                self.data = item
            } catch {
                print(error)
                self.data = nil
            }
                     
            self.loading = false
        }

        task.resume()
    }
}

struct ContentView: View {
    private let storyIds = [
        22862053,
        22859935,
        22861452,
        22862736,
        22858752,
        22861731,
        22863327,
        22859695,
        22858662,
        22860682,
        22864194,
        22861467,
        22859649,
        22859820,
        22864188,
        22861640,
    ]
    
    var body: some View {
        NavigationView {
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
