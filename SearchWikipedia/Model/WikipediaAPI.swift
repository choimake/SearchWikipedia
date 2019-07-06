//
// Created by choimake on 2019-07-06.
//


import Alamofire
import RxSwift

protocol WikipediaAPI {
    func search(from text: String) -> Observable<[WikipediaPage]>
}

class WikipediaDefaultAPI: WikipediaAPI {

    private let endPoint = "https://www.mediawiki.org/w/api.php"

    func search(from word: String) -> Observable<[WikipediaPage]> {
        return Observable<[WikipediaPage]>.create {
            observer in

            let parameters: Parameters = [
                "format": "json",
                "action": "query",
                "list": "search",
                "srsearch": word
            ]

            Alamofire.request(self.endPoint, method: .get, parameters: parameters, encoding: URLEncoding.default)
                    .responseJSON { response in
                        switch response.result {
                        case .success:
                            // wikipediaの検索結果によっては、decodeに失敗する場合があるので、そのときのための例外処理
                            // ex) 検索用のワードが空文字
                            do {
                                let result = try JSONDecoder().decode(WikipeidaSearchResponse.self, from: response.data!)
                                observer.onNext(result.query.search)
                                observer.onCompleted()
                            } catch {
                                observer.onError(error)
                            }

                        case .failure(let error):
                            print("\(error)")
                            observer.onError(error)
                        }
                    }

            return Disposables.create()
        }
    }
}