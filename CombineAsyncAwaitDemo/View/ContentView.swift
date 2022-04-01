//
//  ContentView.swift
// CombineAsyncAwaitDemo
//
//  Created by Ravi Kiran HR on 21/03/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var feedViewModel = FeedViewModel()
    @State var text = String()
    
    var body: some View {
        
        List(feedViewModel.feeds) { feed in
            Text(feed.name)
                .padding()
        }.onAppear {
//            feedViewModel.fetchFeeds()
            feedViewModel.fetchFeedsAsync()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
