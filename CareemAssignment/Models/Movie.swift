//
//  MovieInfo.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 23/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation

/*
 {
  "adult": false,
  "backdrop_path": "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
  "belongs_to_collection": null,
  "budget": 63000000,
  "genres": [
    {
      "id": 18,
      "name": "Drama"
    }
  ],
  "homepage": "",
  "id": 550,
  "imdb_id": "tt0137523",
  "original_language": "en",
  "original_title": "Fight Club",
  "overview": "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
  "popularity": 0.5,
  "poster_path": null,
  "production_companies": [
    {
      "name": "20th Century Fox",
      "id": 25
    }
  ],
  "production_countries": [
    {
      "iso_3166_1": "US",
      "name": "United States of America"
    }
  ],
  "release_date": "1999-10-12",
  "revenue": 100853753,
  "runtime": 139,
  "spoken_languages": [
    {
      "iso_639_1": "en",
      "name": "English"
    }
  ],
  "status": "Released",
  "tagline": "How much can you know about yourself if you've never been in a fight?",
  "title": "Fight Club",
  "video": false,
  "vote_average": 7.8,
  "vote_count": 3439
}
*/
struct Movie {
    var id: Int64
    var overview: String?
    var posterPath: String?
    var releaseDate: Date?
    var title: String

    private enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}

extension Movie : Encodable {
    func encode(to encoder: Encoder) throws {
        let formatter = DateFormatter.commonWebFormat

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(overview, forKey: .overview)
        try container.encode(posterPath, forKey: .posterPath)
        if let releaseDate = releaseDate {
            try container.encode(formatter.string(from: releaseDate), forKey: .releaseDate)
        } else {
            try container.encode("", forKey: .releaseDate)
        }
        try container.encode(title, forKey: .title)
    }
}

extension Movie : Decodable {
    init(from decoder: Decoder) throws {
        let formatter = DateFormatter.commonWebFormat

        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        overview = try container.decode(String?.self, forKey: .overview)
        posterPath = try container.decode(String?.self, forKey: .posterPath)
        releaseDate = formatter.date(from: try container.decode(String.self, forKey: .releaseDate))
        title = try container.decode(String.self, forKey: .title)
    }
}
