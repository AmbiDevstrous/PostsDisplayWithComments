//
//  DisplayedPost.swift
//  PostDisplayWithComments
//
//  Created by Macbook on 8/07/23.
//

import Foundation

//struct DisplayPost: Identifiable {
//    let post:Post
//
//}
struct DisplayedPost: Identifiable {
    let userId :Int
    let id : Int
    let title: String
    let body: String
    var displayComments:Bool = false
    
    init(post:Post) {
        userId = post.userId
        id = post.id
        title = post.title
        body = post.body
    }

    init(displayedPost:DisplayedPost) {
        userId = displayedPost.userId
        id = displayedPost.id
        title = displayedPost.title
        body = displayedPost.body
    }
}

