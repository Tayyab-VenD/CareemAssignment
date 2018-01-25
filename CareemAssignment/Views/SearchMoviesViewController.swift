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

    @IBOutlet private weak var searchField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var suggestionsTableView: UITableView!

    var viewModel: SearchMoviesViewModel!

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
            case.suggestionsRefreshed:
                self.displaySuggestions()
            case .noResultFound:
                self.showOKAlert(title: "", message: "There are no movies that matched your query.")
            case .didUpdateResults:
                self.displayResults()
            case .didReceiveError(_):
                self.showNetworkError()
            }
        }

        searchField.becomeFirstResponder()
        viewModel.refreshSuggestions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func displaySuggestions() {
        tableView.isHidden = true
        suggestionsTableView.isHidden = false
        suggestionsTableView.reloadData()
    }

    private func displayResults() {
        suggestionsTableView.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
        tableView.finishInfiniteScroll()
    }
}

extension SearchMoviesViewController : UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == suggestionsTableView {
            return viewModel.suggestions.count
        }

        return viewModel.searchResults.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == suggestionsTableView {
            let item = viewModel.suggestions[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath)
            let label = cell.viewWithTag(1) as! UILabel
            label.text = item.text
            return cell
        }

        let item = viewModel.searchResults[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieResultCell", for: indexPath) as! MovieResultCell
        cell.configure(with: MovieResultViewModel(service: MovieDBWebService.standard, movie: item))

        return cell
    }
}

extension SearchMoviesViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == suggestionsTableView {
            let item = viewModel.suggestions[indexPath.row]
            viewModel.searchMovies(query: item.text)
            searchField.resignFirstResponder()
        }
    }
}

extension SearchMoviesViewController : UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewModel.refreshSuggestions()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let query = textField.text ?? ""
        if !query.isEmpty {
            viewModel.searchMovies(query: query)
            textField.resignFirstResponder()
        }

        return true
    }
}
