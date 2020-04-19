import Foundation

class ContentViewController: ObservableObject {
    @Published var loadedStories: Array<StoryItem> = []
    
    @Published var activeStory: StoryItem? = nil
    
    @Published var shouldShowComments: Bool = false

    @Published var shouldShowFeed: Bool = false

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
    
    func fetchStory(storyId: Int, callback: @escaping (_ storyItem: StoryItem?) -> Void) {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(storyId).json")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                print(String(error.debugDescription))
                callback(nil)
                return
            }
            
            do {
                let item: StoryItem = try JSONDecoder().decode(StoryItem.self, from: data)
                callback(item)
            } catch {
                print(error)
                callback(nil)
            }
        }

        task.resume()
    }
    
    init() {
        self.storyIds.forEach { storyId in
            self.fetchStory(storyId: storyId) { (_ storyItem: StoryItem?) in
                if storyItem == nil {
                    return
                }
                
                DispatchQueue.main.async {
                    self.loadedStories.append(storyItem!)
                    if self.loadedStories.count > 0 {
                        self.activeStory = self.loadedStories[0]
                    }
                }
            }
        }
    }
    
    public func isActiveStory(_ storyItem: StoryItem) -> Bool {
        return storyItem == self.activeStory
    }
    
    public func setActiveStory(_ storyItem: StoryItem) -> Void {
        self.activeStory = storyItem
    }
}
