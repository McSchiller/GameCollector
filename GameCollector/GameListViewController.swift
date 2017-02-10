//
//  GameListViewController.swift
//  GameCollector
//
//  Created by Andreas Schiller on 10.02.17.
//  Copyright © 2017 Schiller. All rights reserved.
//

import UIKit

class GameListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var gameTableView: UITableView!
    
    var games :[Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameTableView.dataSource = self
        gameTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let game = games[indexPath.row]
        cell.textLabel?.text = game.name
        cell.imageView?.image = UIImage(data: game.image! as Data)
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = games[indexPath.row]
        performSegue(withIdentifier: "gameSegue", sender: game)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! GameViewController
        nextVC.game = sender as? Game
    }

    override func viewWillAppear(_ animated: Bool) {
        let manager = UIApplication.shared.delegate as! AppDelegate
        let context = manager.persistentContainer.viewContext
        
        do{
            games = try context.fetch(Game.fetchRequest())
            gameTableView.reloadData()
        }catch{
            print("Database Error by loading Games")
        }
    }

}

