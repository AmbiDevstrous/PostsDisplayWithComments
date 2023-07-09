//
//  PostDisplayConfig.swift
//  PostDisplayWithComments
//
//  Created by Macbook on 8/07/23.
//

import Foundation
final class PostDisplayConfig : ObservableObject
{
    var posts: [Post]?
    var displayedPosts:[DisplayedPost]?
    var alteredPost:[DisplayedPost]?
    @Published var isLoading = false
    private(set) var localizedDescription: String?
    public var service = GetPostsService()
    @Published var reloader = false

    
    func fetch()  {
        self.isLoading = true
        Task {
            do {
                self.posts = try await self.service.fetchPosts()
                self.displayedPosts = []
                for post in self.posts! {
                    var displayedPost = DisplayedPost(post: post)
                    displayedPosts!.append(displayedPost)
                }
                self.isLoading = false

            } catch {
                localizedDescription = error.localizedDescription
            }
        }
    }
}

final class GetPostsService {
    enum ServiceError: Error, LocalizedError {
        case cannotCreateURL
        case urlSessionDidFail
        case cannotDecodeData
        
        var localizedDescription: String {
            switch self {
            case .cannotCreateURL:
                return "Cannot Create URL" // bad url
            case .urlSessionDidFail:
                return "URL Session Failed" //url failed on get.
            case .cannotDecodeData:
                return "Cannot Decode Data" //model did not match json properties.
            }
        }
    }
    
    private let urlString = "https://jsonplaceholder.typicode.com/posts"
    private let jsonDecoder = JSONDecoder()
    private(set) var posts: [Post]?
    
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: urlString) else {
            throw ServiceError.cannotCreateURL
        }
        
        let request = URLRequest(url: url)
        let data: Data
        
        do {
            data = try await URLSession.shared.data(for: request).0
            
        } catch {
            throw ServiceError.urlSessionDidFail
        }
        do {
            posts = try jsonDecoder.decode([Post].self, from: data)
        } catch {
            throw ServiceError.cannotDecodeData
        }
        return posts!
    }
}
