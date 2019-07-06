//
// Created by choimake on 2019-07-06.
//


import Foundation
import RxSwift

struct WikipeidaSearchResponse: Decodable {
    let query: Query

    struct Query: Decodable {
        let search: [WikipediaPage]
    }
}

struct WikipediaPage {
    let id: String
    let title: String
    let url: String
}

extension WikipediaPage: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id = "pageid"
        case title
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = String(try container.decode(Int.self, forKey: .id))
        self.title = try container.decode(String.self, forKey: .title)

        self.url = "https://ja.wikipedia.org/w/index.php?curid=\(id)"
    }
}


