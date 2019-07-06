//
// Created by choimake on 2019-07-05.
//

import RxSwift
import RxCocoa

class WikipediaSearchViewModel: ViewModelType {

    private let wikipediaAPI: WikipediaAPI
    private let scheduler: SchedulerType

    private let disposeBag = DisposeBag()

    init(wikipediaAPI: WikipediaAPI, scheduler: SchedulerType) {
        self.wikipediaAPI = wikipediaAPI
        self.scheduler = scheduler
    }
}

extension WikipediaSearchViewModel {

    struct Input {
        let searchText: Observable<String>
    }

    struct Output {
        let searchResult: Observable<[WikipediaPage]>
    }

    func transform(input: Input) -> Output {
        let filterText = input.searchText.debounce(.microseconds(300), scheduler: scheduler).share(replay: 1)

        let sequence = filterText.flatMapLatest {
            [unowned self] text -> Observable<Event<[WikipediaPage]>> in
            return self.wikipediaAPI.search(from: text).materialize()
        }.share(replay: 1)

        let searchResult = sequence.compactMap {
            $0.event.element
        }

        return Output(
                searchResult: searchResult
        )
    }
}
