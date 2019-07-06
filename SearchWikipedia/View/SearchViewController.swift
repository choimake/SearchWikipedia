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
    @IBOutlet weak var tableView: UITableView!

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

        output.searchResult.bind(to: tableView.rx.items(cellIdentifier: "Cell")) {
            (index, result, cell) in
            cell.textLabel?.text = result.title
            cell.detailTextLabel?.text = result.url
        }.disposed(by: disposeBag)

        self.viewModel = viewModel
    }


}

