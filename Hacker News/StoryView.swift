import Foundation
import SwiftUI
import WebKit

struct StoryItem: Decodable, Equatable {
    let title: String
    let url: String?
    let id: Int
    
    static func == (lsh: StoryItem, rsh: StoryItem) -> Bool {
        return String("\(lsh.title):\(lsh.url)") == String("\(rsh.title):\(rsh.url)")
    }
}

class UrlWatcher : ObservableObject {
    @Published var url: String = ""
}



struct StoryView: View {
    public var storyItem: StoryItem
        
    @State private var title: String = "Hello"
    
    var body: some View {
        VStack {
            WebView(title: self.$title, url: URL(string: self.storyItem.url!)!)
        }
    }
    
}
