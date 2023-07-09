//
//  ContentView.swift
//  PostDisplayWithComments
//
//  Created by Macbook on 7/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var config = PostDisplayConfig()
 //   var posts:[Post] = config.posts!
     //var displayedPosts: [DisplayedPost]?
    var body: some View {
            //provides swipe delete?
                if config.isLoading {
                    LoadingView()
                    //if there is any delay between fetching data and displaying, show loading view.
                } else if let posts = config.posts {
                    SuccessView(config: config, posts: posts)
                } else if config.localizedDescription == nil {
                    Button("Fetch Posts!") {
                        config.fetch()
                    }
                }else {
                    ErrorView(localizedError: config.localizedDescription!)
                }
    }
    
    struct LoadingView : View {
        
        var body: some View {
            Text("Loading ...")
                .font(.subheadline)
                .padding()
        }
    }
    
    struct ErrorView: View {
        
        let localizedError: String
        
        var body: some View {
            Text(localizedError)
                .padding()
        }
    }
    
    struct SuccessView: View {
        
        @ObservedObject
        var config: PostDisplayConfig
        let posts: [Post]
        
        var body: some View {
            List {
                //provides swipe delete?
                Section { // to seperate the list between header and its content sections.
                    ForEach(posts) { post in
                        HStack {
                            Text(post.title)
                            Spacer()
                            VStack {
                                Image(systemName: "heart.fill")
                                Button(""){
                                    
                                }
                            }
                           
                        }
                    }
                } header: {
                    Text("Post title")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
