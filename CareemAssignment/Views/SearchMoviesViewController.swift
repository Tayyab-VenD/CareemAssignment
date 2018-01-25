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
    @IBOutlet private weak var resultsTableView: UITableView!
    @IBOutlet private weak var suggestionsTableView: UITableView!

    var viewModel: SearchMoviesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure infinite scrolling of search resutls.
        resultsTableView.addInfiniteScroll { (tableView) in
            self.viewModel.loadMoreResults()
        }
        resultsTableView.setShouldShowInfiniteScrollHandler { (tableView) -> Bool in
            return self.viewModel.hasMoreResults
        }

        // Configure the view model.
        viewModel.on { (event) in
            switch event {
            case.suggestionsRefreshed:
                self.displaySuggestions()
            case .noResultFound:
                self.showOKAlert(title: "", message: "There are no movies that matched your query.")
            case .resultsUpdated:
                self.displayResults()
            case .apiError(_):
                self.showNetworkError()
            }
        }

        // Focus the search field and refresh the suggestions.
        searchField.becomeFirstResponder()
        viewModel.refreshSuggestions()
    }

    private func searchMovies(query: String) {
        // Schedule the search request and hide the keybaord.
        viewModel.searchMovies(query: query)
        searchField.resignFirstResponder()

        // Scroll the results table to top.
        let indexPath = IndexPath(row: NSNotFound, section: 0)
        resultsTableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }

    private func displaySuggestions() {
        resultsTableView.isHidden = true
        suggestionsTableView.isHidden = false
        suggestionsTableView.reloadData()
    }

    private func displayResults() {
        suggestionsTableView.isHidden = true
        resultsTableView.isHidden = false
        resultsTableView.reloadData()
        resultsTableView.finishInfiniteScroll()
    }
}

// MARK: - UITextFieldDelegate
extension SearchMoviesViewController : UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewModel.refreshSuggestions()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let query = textField.text ?? ""
        if !query.isEmpty {
            searchMovies(query: query)
        }

        return true
    }
}

// MARK: - UITableViewDataSource
extension SearchMoviesViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == suggestionsTableView {
            return viewModel.suggestions.count
        }

        if tableView == resultsTableView {
            return viewModel.searchResults.count
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == suggestionsTableView {
            let item = viewModel.suggestions[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath)
            let label = cell.viewWithTag(1) as! UILabel
            label.text = item.text

            return cell
        }

        if tableView == resultsTableView {
            let item = viewModel.searchResults[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieResultCell", for: indexPath) as! MovieResultCell
            cell.configure(with: MovieResultViewModel(service: viewModel.service, movie: item))

            return cell
        }

        fatalError()
    }
}

// MARK: - UITableViewDelegate
extension SearchMoviesViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if tableView == suggestionsTableView {
            let item = viewModel.suggestions[indexPath.row]
            searchMovies(query: item.text)
        }
    }
}
