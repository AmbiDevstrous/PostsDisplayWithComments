//
//  DisplayedPost.swift
//  PostDisplayWithComments
//
//  Created by Macbook on 8/07/23.
//

import Foundation

final class DisplayedPost : ObservableObject, Identifiable{
    var post:Post?
    @Published var displayComments:Bool = false
}

