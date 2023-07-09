//
//  Post.swift
//  PostDisplayWithComments
//
//  Created by Macbook on 7/07/23.
//

import Foundation
import SwiftUI


struct Post:Decodable, Identifiable {
    
    let userId :Int
    let id : Int
    let title: String
    let body: String
}




