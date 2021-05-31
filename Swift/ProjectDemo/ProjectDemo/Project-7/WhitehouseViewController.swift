//
//  WhitehouseViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/5/31.
//

import UIKit

class WhitehouseViewController: UITableViewController {
    
    private var petitions = Petitions(results: []) {
        didSet { tableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()

        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        
        guard let url = URL(string: urlString),
              let data = try? Data(contentsOf: url) else {
            showError()
            return
        }
        
        parse(json: data)
    }
    
    private func parse(json: Data) {
        let decoder = JSONDecoder()
        
        guard let jsonPetitions = try? decoder.decode(Petitions.self, from: json) else {
            showError()
            return
        }
        
        petitions = jsonPetitions
    }
    
    private func showError() {
        let alert = UIAlertController(title: "Loading Error",
                                      message: "There was a problem loading the feed; please check your connection and try again.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好的", style: .default))
        present(alert, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Whitehouse", for: indexPath)
        let petition = petitions.results[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WhitehouseDetailViewController()
        vc.detailItem = petitions.results[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
