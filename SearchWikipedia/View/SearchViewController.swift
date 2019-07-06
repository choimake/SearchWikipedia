//
//  SearchViewController.swift
//  SearchWikipedia
//
//  Created by choimake on 2019/07/05.
//  Copyright © 2019 choimake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!

    var viewModel: WikipediaSearchViewModel!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let input = WikipediaSearchViewModel.Input(
                searchText: searchBar.rx.text.orEmpty.asObservable()
        )

        let viewModel = WikipediaSearchViewModel(
                wikipediaAPI: WikipediaDefaultAPI(),
                scheduler: MainScheduler.instance
        )

        let output = viewModel.transform(input: input)

        output.searchResult.subscribe(
                onNext: {
                    value in
                    print(value)
                }
        ).disposed(by: disposeBag)

        self.viewModel = viewModel
    }


}

