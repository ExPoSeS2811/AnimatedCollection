//
//  Post.swift
//  AnimatedCollection
//
//  Created by Gleb Rasskazov on 08.09.2023.
//

import Foundation

enum Type: String {
    case upscale, downscale, descale, rescale
}

struct Post {
    let houseName: String
    let description: String
    let size: String
    let type: Type
    let date: String
    let image: String

    static func getPosts() -> [Post] {
        [
            Post(houseName: "Cozy Apartment", description: "Beautiful apartment in a quiet neighborhood.", size: "80 sq.m", type: .upscale, date: "2023-09-08", image: "house3.jpg"),
            Post(houseName: "Family House", description: "Spacious house with a garden for the whole family.", size: "250 sq.m", type: .downscale, date: "2023-09-07", image: "house1.jpg"),
            Post(houseName: "Modern Apartments", description: "Modern apartments with a mountain view.", size: "90 sq.m", type: .upscale, date: "2023-09-06", image: "house6.jpg"),
            Post(houseName: "Historic Mansion", description: "Historic mansion with a rich history.", size: "300 sq.m", type: .downscale, date: "2023-09-05", image: "house2.jpg"),
            Post(houseName: "River View Apartment", description: "Comfortable apartment with panoramic windows.", size: "70 sq.m", type: .upscale, date: "2023-09-04", image: "house4.jpg"),
            Post(houseName: "Modern House with Pool", description: "Modern house with a pool and sauna.", size: "180 sq.m", type: .downscale, date: "2023-09-03", image: "house3.jpg"),
            Post(houseName: "Duplex in City Center", description: "Sleek duplex with a spacious kitchen.", size: "120 sq.m", type: .upscale, date: "2023-09-02", image: "house1.jpg"),
            Post(houseName: "Cozy Retreat for Two", description: "Compact apartment for romantic couples.", size: "50 sq.m", type: .upscale, date: "2023-09-01", image: "house5.jpg"),
            Post(houseName: "Family Cottage", description: "Spacious cottage for a large family.", size: "320 sq.m", type: .downscale, date: "2023-08-31", image: "house4.jpg"),
            Post(houseName: "Atmospheric Loft", description: "Stylish loft in the city center.", size: "110 sq.m", type: .upscale, date: "2023-08-30", image: "house3.jpg"),
            Post(houseName: "Ocean View House", description: "Luxurious house with panoramic ocean views.", size: "400 sq.m", type: .downscale, date: "2023-08-29", image: "house5.jpg"),
            Post(houseName: "Business District Apartments", description: "Modern apartments in the business district.", size: "85 sq.m", type: .upscale, date: "2023-08-28", image: "house4.jpg"),
            Post(houseName: "House with Pool and Garden", description: "Comfortable house with a pool and well-maintained garden.", size: "280 sq.m", type: .downscale, date: "2023-08-27", image: "house6.jpg"),
            Post(houseName: "Apartment with Panoramic Window", description: "Spacious apartment with a magnificent view.", size: "95 sq.m", type: .upscale, date: "2023-08-26", image: "house2.jpg"),
            Post(houseName: "Historic Manor", description: "Famous historic manor in the old town.", size: "350 sq.m", type: .downscale, date: "2023-08-25", image: "house5.jpg")
        ]
    }
}
