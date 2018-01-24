//
//  ViewController.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 23/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

class SearchMoviesViewController: UIViewController {

    private let viewModel = SearchMoviesViewModel(service: MovieDBWebService.standard)

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure infinite scrolling.
        tableView.addInfiniteScroll { (tableView) in
            self.viewModel.loadMoreResults()
        }
        tableView.setShouldShowInfiniteScrollHandler { (tableView) -> Bool in
            return self.viewModel.hasMoreResults
        }

        viewModel.on { (event) in
            switch event {
            case .noResultFound:
                self.showOKAlert(title: "", message: "There are no movies that matched your query.")
            case .didUpdateResults:
                self.displayResults()
            case .didReceiveError(_):
                self.showNetworkError()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func displayResults() {
        tableView.reloadData()
        tableView.finishInfiniteScroll()
    }
}

extension SearchMoviesViewController : UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResults.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.searchResults[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieResultCell", for: indexPath) as! MovieResultCell
        cell.configure(with: MovieResultViewModel(service: MovieDBWebService.standard, movie: item))

        return cell
    }
}

extension SearchMoviesViewController : UITableViewDelegate {

}

extension SearchMoviesViewController : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let query = textField.text ?? ""
        if !query.isEmpty {
            viewModel.searchMovies(query: query)
        }

        return true
    }
}
