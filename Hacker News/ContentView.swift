//
//  ContentView.swift
//  Hacker News
//
//  Created by Bryce Hanscomb on 14/4/20.
//  Copyright © 2020 Bryce Hanscomb. All rights reserved.
//

import SwiftUI


struct StoryLink: View {
    public let story: StoryItem
    public let isActive: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text(self.story.title).frame(maxWidth: .infinity, alignment: .topLeading).padding(15)
        }
        .background(self.isActive
            ? Color(NSColor.selectedContentBackgroundColor)
            : Color(NSColor.textBackgroundColor)
        )
    }
//    public let storyId: Int
//    public let isActive: Bool
//    @Binding public var storyItem: StoryItem
//
//    @State private var loading: Bool = false
//
//    @State private var data: Optional<StoryItem> = nil
//
//    var body: some View {
//        VStack(spacing: 0) {
//            Text(self.getLabel()).onAppear {
//                self.fetchStory()
//            }.frame(maxWidth: .infinity, alignment: .topLeading).padding(15)
//            Divider()
//        }.background(self.isActive ? Color(NSColor.selectedContentBackgroundColor) : Color(NSColor.textBackgroundColor)).onTapGesture {
//            self.storyItem = self.data!
//        }
//    }
//
//    private func getLabel() -> String {
//        if self.loading {
//            return "Loading..."
//        }
//
//        if let story = self.data {
//            return story.title
//        }
//
//        return String("Story \(self.storyId)")
//    }
//
//    private func fetchStory() {
//        let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(self.storyId).json")!
//
//        self.loading = true
//
//        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//            guard let data = data else {
//                print(String(error.debugDescription))
//                self.loading = false
//                return
//            }
//
//            do {
//                let item: StoryItem = try JSONDecoder().decode(StoryItem.self, from: data)
//                self.data = item
//            } catch {
//                print(error)
//                self.data = nil
//            }
//
//            self.loading = false
//        }
//
//        task.resume()
//    }
}

struct ContentView: View {
    @ObservedObject private var vm = ContentViewController()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(self.vm.loadedStories, id: \.title) { storyItem in
                    StoryLink(story: storyItem, isActive: self.vm.isActiveStory(storyItem)).onTapGesture {
                        self.vm.setActiveStory(storyItem)
                    }
                }
            }.frame(maxWidth: 300)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
