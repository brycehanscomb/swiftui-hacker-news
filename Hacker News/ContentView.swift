//
//  ContentView.swift
//  Hacker News
//
//  Created by Bryce Hanscomb on 14/4/20.
//  Copyright © 2020 Bryce Hanscomb. All rights reserved.
//

import SwiftUI

struct StoryItem: Decodable {
    let title: String
    let url: String?
}

struct MainView: View {
    public var _storyId: Int
    
    @State private var url: String = "https://google.com";
    
    init(storyId: Int) {
        self._storyId = storyId
        self.fetchStory()
    }
    
    var body: some View {
        VStack {
            Text("(Load a webview here for the URL of Story #\(self._storyId))")
            Text("URL is: \(self.url)")
        }
    }
    
    private func fetchStory() {
        print("loading")
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(self._storyId).json")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                print(String(error.debugDescription))
                return
            }
            
            do {
                let item: StoryItem = try JSONDecoder().decode(StoryItem.self, from: data)
                
                if let storyUrl = item.url {
                    print("url = \(storyUrl)")
                    self.url = storyUrl
                } else {
                    print("No url")
                }
            } catch {
                print(error)
            }
        }

        task.resume()
    }
}

struct StoryLink: View {
    public let storyId: Int
    public let isActive: Bool
    
    @State private var loading: Bool = false
    
    @State private var data: Optional<StoryItem> = nil
    
    var body: some View {
        VStack(spacing: 0) {
            Text(self.getLabel()).onAppear {
                self.fetchStory()
            }.frame(maxWidth: .infinity, alignment: .topLeading).padding(15)
            Divider()
        }.background(self.isActive ? Color(NSColor.selectedContentBackgroundColor) : Color(NSColor.textBackgroundColor))
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
    
    @State var activeItem: Int = 22862053
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(self.storyIds, id: \.self) { storyId in
                    StoryLink(storyId: storyId, isActive: storyId == self.activeItem).frame(maxWidth: .infinity).onTapGesture {
                        self.activeItem = storyId
                    }.offset(x: 0, y: CGFloat(self.storyIds.firstIndex(of: storyId)! * -7)) // there's a weird 7px gap between items when using a Divider()
                }
            }.frame(minWidth: 200, maxWidth: 400).background(Color(NSColor.textBackgroundColor))
            MainView(storyId: self.activeItem).frame(maxWidth: .infinity, maxHeight: .infinity)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
