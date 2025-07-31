//
//  Photo.swift
//  UIKit5
//
//  Created by 송재훈 on 7/31/25.
//

struct Photo: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}
