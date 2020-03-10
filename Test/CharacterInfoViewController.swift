//
//  CharacterInfoViewController.swift
//  Test
//
//  Created by Владислав on 3/10/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

import UIKit

class CharacterInfoViewController: UIViewController {

    @IBOutlet var tableView:UITableView!
    var characterInfo: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
}

extension CharacterInfoViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detal") as? DetalInfoTableViewCell else {return UITableViewCell()}
        
        cell.name.text = characterInfo?.name
        cell.gender.text = "Пол: " + characterInfo!.gender
        cell.status.text = "Статус: " + characterInfo!.status
        cell.species.text = "Вид: " + characterInfo!.species
        
        var image: UIImage?
        let imageURL = URL(string: characterInfo!.image)
        if let url = imageURL {
            
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                DispatchQueue.main.async {
                    if imageData != nil {
                        image = UIImage(data: imageData! as Data)
                        cell.imageCharacter.image = image
                        cell.imageCharacter.layer.cornerRadius = 10
                    } else {
                        image = nil
                    }
                }
            }
        }
        return cell
    }
    
    
}
