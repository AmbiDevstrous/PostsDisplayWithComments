

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
                            Text(post.title)
                            Spacer()
                            VStack {
                                Image(systemName: "heart.fill")
                                Button(""){
                                    config.alteredPost = config.displayedPosts
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
