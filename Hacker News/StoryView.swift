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

struct StoryView: View {
    public var _storyId: Int
    
    @ObservedObject private var urlWatcher = UrlWatcher();
    
    @State private var title: String = "Hello"
    
    init(storyId: Int) {
        self._storyId = storyId
        self.fetchStory()
    }
    
    var body: some View {
        VStack {
            Text("(Load a webview here for the URL of Story #\(self._storyId))")
            Text("URL is: \(self.urlWatcher.url)")
            if self.urlWatcher.url.count > 0 {
                WebView(title: self.$title, url: URL(string: self.urlWatcher.url)!)
            }
        }
    }
    
    private func fetchStory() {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(self._storyId).json")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                print(String(error.debugDescription))
                return
            }
            
            do {
                let item: StoryItem = try JSONDecoder().decode(StoryItem.self, from: data)
                
                if let storyUrl = item.url {
                    DispatchQueue.main.async {
                        self.urlWatcher.url = storyUrl
                    }
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

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(storyId: 22862053)
    }
}
