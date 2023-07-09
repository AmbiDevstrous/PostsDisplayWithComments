

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
                } else if let displayedPosts = config.displayedPosts {
                    SuccessView(config: config, displayedPosts: displayedPosts)
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
        let displayedPosts: [DisplayedPost]
        
        var body: some View {
            List {
                //provides swipe delete?
                Section { // to seperate the list between header and its content sections.
                    ForEach(config.displayedPosts!) { post in
                        HStack {
                            Text(post.title).frame(width: 100, height: 100, alignment: .leading).lineLimit(1)
                            Spacer()
                            VStack {
                                if post.displayComments == true {
                                    Image(systemName: "heart.fill").frame(width: 40, height: 100)
                                }
                                else {
                                    Text(post.body).frame(width: 170, height: 100, alignment: .leading).lineLimit(5)
                                }
                                Button(""){
                                    config.alteredPost = []
                                    for p in config.displayedPosts! {
                                        if post.id == p.id {
                                            var dp = DisplayedPost(displayedPost: p)
                                            dp.displayComments = !post.displayComments
                                            
                                            config.alteredPost!.append(dp)
                                        }
                                        else {
                                            config.alteredPost!.append(post)
                                        }
                                    }
                                    config.alteredPost = config.displayedPosts
                                    config.reloader = !config.reloader
                                }
                            }
                            
                        }
                         
//                            if post.displayComments == true {
//                                Spacer()
//                                Text(post.body)
//                            }
                            
                    
                    }
                } header: {
                    HStack {
                        Text("Title").frame(width: 100, alignment: .leading)
                        Spacer()
                        Text("Content").frame(width: 170, alignment: .leading)
                    }
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
