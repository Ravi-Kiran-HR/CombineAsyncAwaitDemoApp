//
//  RemoteFeedLoader.swift
// CombineAsyncAwaitDemo
//
//  Created by Ravi Kiran HR on 21/03/22.
//

import Foundation
import Combine

class RemoteFeedLoader: FeedLoadable {
    let url: URL
    
    init (url: URL) {
        self.url = url
    }
    
    func load() -> FeedResult {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [FeedItem].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func loadAsync() async -> FeedAsyncResult {
        do {
            let (data, _ ) = try await URLSession.shared.data(from: url, delegate: nil)
            let feeds = try JSONDecoder().decode([FeedItem].self, from: data)
            return .success(feeds)
        }
        catch (let error) {
            return .failure(error)
        }
    }
}
