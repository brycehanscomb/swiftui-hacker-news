import Foundation
import SwiftUI
import WebKit

struct StoryItem: Decodable {
    let title: String
    let url: String?
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
