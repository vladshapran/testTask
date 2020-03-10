//
//  CharacterTableViewController.swift
//  Test
//
//  Created by Владислав on 3/10/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    
    var character: Result?
    
    let url = URL(string: "https://rickandmortyapi.com/api/character/")
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dowloandJson()
        tableView.tableFooterView = UIView()
       
        
    }
    
    @IBAction func tapButton(_ sender: UIButton){
        
       sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            self.character?.results.sort(by: {
                $0.name < $1.name
            })
        } else {
            self.character?.results.sort(by: {
                $0.name > $1.name
            })
        }
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
        
    }
    

    
    func dowloandJson() {
        guard let dowloandURL = url else {
            return
        }
        URLSession.shared.dataTask(with: dowloandURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                
                return
            }
            do {
                let dowloandedPerson = try JSONDecoder().decode(Result.self, from: data)
                self.character = dowloandedPerson
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
            }catch{
            }
        }.resume()
    }
    

}


    extension CharacterViewController: UITableViewDataSource, UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return (character?.results.count ?? 0)
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SelectTableViewCell else {return UITableViewCell()}
            
            cell.name.text = (character?.results[indexPath.row].name ?? "")
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let characterVC = storyboard?.instantiateViewController(withIdentifier: "characterInfo") as! CharacterInfoViewController
            characterVC.characterInfo = character!.results[indexPath.row]
            self.navigationController?.pushViewController(characterVC, animated: true)
        }
    
    }
