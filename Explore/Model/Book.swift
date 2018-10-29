//
//  Product.swift
//  Explore
//
//  Created by Badarinath Venkatnarayansetty on 10/20/18.
//  Copyright © 2018 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation


struct Model: Decodable {
    var posts:[Post]
    var comments:[Comment]
    var books:[Book]
}

struct Post:Decodable {
    var id:Int
    var title:String
}

struct Comment: Decodable {
    var id:Int
    var body:String
    var postId:Int
}

struct Book:Decodable {
    var id:Int
    var title:String
    var image:String
    var author:String
}
