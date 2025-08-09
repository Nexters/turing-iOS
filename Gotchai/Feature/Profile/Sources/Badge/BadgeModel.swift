//
//  BadgeModel.swift
//  Profile
//
//  Created by 가은 on 8/9/25.
//

import Foundation

struct Badge: Identifiable {
    let id = UUID()
    let imageURL: String
    let name: String
}

extension Badge {
    static let dummyList: [Badge] = (0..<12).map { index in
        Badge(imageURL: "", name: "기계사냥꾼 \(index)")
    }
}
