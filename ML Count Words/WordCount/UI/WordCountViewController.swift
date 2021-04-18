//
//  WordCountViewController.swift
//  ML Count Words
//
//  Created by Ferran Rosales on 15/4/21.
//

import UIKit


class WordCountViewController: UIViewController {
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    let scrollView = UIScrollView()
    let contentView = UIStackView()
    
    let header = UIView()
    let body = UIView()
    
    
    let tableView = UITableView()
    
    var textOfFile = ""
    var nameOfFile = ""
    var numberOfWords = 0
    var filteredString = ""
    var stringArray:[String]!
    var wordCounts = [String: Int]()
    var filteredWordCounts:[String:Int]!
    var keysArray:[String]!
    var valuesArray:[Int]!
    var currentKeysDataSource:  [String] = []
    var currentValuesDataSource:  [Int] = []
    
    var searchController: UISearchController!
    
    
    let headerImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "GrayBG")
        imageview.contentMode = .scaleToFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        
        return imageview
    }()
    
    let homeButton: UIButton = {
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        let image = UIImage(systemName: "chevron.backward")
        button.setImage(image , for: .normal)
        button.tintColor = .white
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(menu(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        return button
        
    }()
    
    let headerBGImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "calculator")
        imageview.contentMode = .scaleToFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.heightAnchor.constraint(equalToConstant: 149).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 196).isActive = true
        return imageview
    }()
    
    let titleHeader: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nombre"

        return label
        
    }()
    
    let subTitleHeader: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Número"

        return label
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setupScrollView()
        setupContentView()
        setupHeader()
        setupTableView()
        
        
    }
    

    private func setData() {
        
        titleHeader.text = nameOfFile
        
        
        while let rangeToReplace = textOfFile.range(of: "\n") {
            textOfFile.replaceSubrange(rangeToReplace, with: " ")
        }
        
        while let rangeToReplace = textOfFile.range(of: "\r") {
            textOfFile.replaceSubrange(rangeToReplace, with: "")
        }
        while let rangeToReplace = textOfFile.range(of: "\t") {
            textOfFile.replaceSubrange(rangeToReplace, with: "")
        }

        
        let words = textOfFile.words
        
        numberOfWords = words.count
        subTitleHeader.text = "\(numberOfWords) palabras"
        stringArray = textOfFile.components(separatedBy: " ")
        
        
        for word in words  {
            wordCounts[word, default: 0] += 1
        }
        filteredWordCounts = wordCounts.filter({!$0.key.isEmpty})
        
        keysArray = Array(filteredWordCounts.keys)
        valuesArray = Array(filteredWordCounts.values)
        
        currentKeysDataSource = keysArray
        currentValuesDataSource = valuesArray
 
    }
    
    private func setupScrollView() {
        
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupContentView() {
        contentView.axis            = .vertical
        contentView.distribution    = .fill
        contentView.alignment       = .fill
        
        scrollView.addSubview(contentView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setupHeader() {
        
        
        header.addSubview(headerImageView)
        
        headerImageView.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        headerImageView.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: 2).isActive = true
        headerImageView.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        
        header.addSubview(homeButton)
        homeButton.topAnchor.constraint(equalTo: header.topAnchor, constant: 50).isActive = true
        homeButton.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 15).isActive = true
        header.addSubview(headerBGImageView)
        headerBGImageView.topAnchor.constraint(equalTo: header.topAnchor, constant: 60).isActive = true
        headerBGImageView.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        
        header.addSubview(titleHeader)
        titleHeader.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -35).isActive = true
        titleHeader.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16).isActive = true
        
        header.addSubview(subTitleHeader)
        subTitleHeader.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -15).isActive = true
        subTitleHeader.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16).isActive = true

        header.clipsToBounds = true
        
        contentView.addArrangedSubview(header)
        header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        
        
    }
    
    private func setupTableView() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar"
        searchController.searchBar.tintColor = UIColor(named: "mid_green")
        searchController.searchBar.backgroundColor = .white

        body.addSubview(searchController.searchBar)
        
        body.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: body.topAnchor, constant: 60).isActive = true
        tableView.leadingAnchor.constraint(equalTo: body.leadingAnchor, constant: 15).isActive = true
        tableView.trailingAnchor.constraint(equalTo: body.trailingAnchor, constant: -15).isActive = true
        //tableView.heightAnchor.constraint(equalTo: body.heightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: body.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(ListOfWordsTableViewCell.self, forCellReuseIdentifier: "cell")
        

        contentView.addArrangedSubview(body)
        body.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.7/3).isActive = true
        
        
    }
    
    private func countString(string: String) -> Int {
        
        let charactersSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let components = string.components(separatedBy: charactersSet)
        let numberOfWords = components.filter {!$0.isEmpty}
        
        return numberOfWords.count
    }
    
    func filterCurrentDataSource(searchTerm: String) {
        
        if searchTerm.count > 0 {
            
            let data = filteredWordCounts
            
            let filteredResults = data!.filter{$0.key.replacingOccurrences(of: " ", with: "").contains(searchTerm.replacingOccurrences(of: " ", with: ""))}
            
            currentKeysDataSource = Array(filteredResults.keys)
            currentValuesDataSource = Array(filteredResults.values)
            
            tableView.reloadData()
       }
    }
    
    func restoreCurrentDataSource() {
        currentKeysDataSource = keysArray
        currentValuesDataSource = valuesArray
        
        tableView.reloadData()
    }
    
    @objc private func menu(sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Home") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
}

extension WordCountViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            filterCurrentDataSource(searchTerm: searchText)
        }
   }
}

extension WordCountViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchText = searchBar.text {
            filterCurrentDataSource(searchTerm: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //searchController.isActive = false
        
        if let searchText = searchBar.text, !searchText.isEmpty {
            restoreCurrentDataSource()
        }
        
        if let searchText = searchBar.text, searchText.isEmpty {
            restoreCurrentDataSource()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            restoreCurrentDataSource()
        }
    }
    
}

extension WordCountViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        currentKeysDataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListOfWordsTableViewCell
        
        
        cell.selectionStyle = .none
        
        cell.wordLabel.text = "\"\(currentKeysDataSource [indexPath.row])\""
        
        if currentValuesDataSource[indexPath.row] == 1 {
            cell.numberLabel.text = "\(currentValuesDataSource[indexPath.row]) vez en el documento"
        } else {
            cell.numberLabel.text = "\(currentValuesDataSource[indexPath.row]) veces en el documento"
        }

        return cell
    }

}

extension StringProtocol {
    var words: [String] {
        split(whereSeparator: \.isLetter.negation).map{String($0)}
    }
}

extension Bool {
    var negation: Bool { !self }
}

