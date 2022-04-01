//
//  FeedLoadable.swift
// CombineAsyncAwaitDemo
//
//  Created by Ravi Kiran HR on 21/03/22.
//

import Foundation
import Combine

typealias FeedResult = AnyPublisher<[FeedItem], Error>
typealias FeedAsyncResult =  Result<[FeedItem], Error>

protocol FeedLoadable {
    func load() -> FeedResult
    func loadAsync() async -> FeedAsyncResult
}
