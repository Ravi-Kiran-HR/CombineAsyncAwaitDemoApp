//
//  ViewModel.swift
// CombineAsyncAwaitDemo
//
//  Created by Ravi Kiran HR on 21/03/22.
//

import Foundation
import Combine

class FeedViewModel: ObservableObject {
    @Published var feeds: [FeedItem] = []
    var publisher = Set<AnyCancellable>()
    
    private let feedService: FeedLoadable
    
    init (feedService: FeedLoadable = RemoteFeedLoader(url: URL(string: "https://jsonplaceholder.typicode.com/users")!)) {
        self.feedService = feedService
    }
    
    func fetchFeeds() {
        feedService.load().sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
            case .finished:
                print("Finished")
            }
        } receiveValue: { items in
            DispatchQueue.main.async { [weak self] in
                self?.feeds = items
            }
        }.store(in: &publisher)
    }
    
    func fetchFeedsAsync() {
        Task(priority: .background) {
            let result = await feedService.loadAsync()
            switch result {
            case .failure(let error):
                print(error)
            case .success(let feedItems):
               await publishFeeds(feeds: feedItems)
            }
        }
    }
    
    @MainActor func publishFeeds(feeds: [FeedItem]) {
        self.feeds = feeds
    }
}
