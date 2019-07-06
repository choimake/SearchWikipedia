//
// Created by choimake on 2019-07-06.
//


import Alamofire
import RxSwift

protocol WikipediaAPI {
    func search(from text: String) -> Observable<[Int]>
}

class WikipediaDefaultAPI: WikipediaAPI {

    func search(from text: String) -> Observable<[Int]> {
        return Observable<[Int]>.create {
            observer in

            let result = [1, 2, 3]

            observer.onNext(result)
            observer.onCompleted()

            return Disposables.create()
        }
    }
}