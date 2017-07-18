//
//  ViewController.swift
//  Planets
//
//  Created by COBE Osijek on 18/07/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var planets = [Planet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("planet") {
                // let range = item.startIndex..<item.index(item.startIndex, offsetBy: 7)
                planets.append(Planet(name: item.replacingOccurrences(of: "planet_", with: ""), image: item))
            }
        }
        print(planets)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "planetCell", for: indexPath) as? PlanetTableViewCell else{
            fatalError("Cell not an instance of PlanetTableViewCell")
        }
        cell.textLabel?.text = planets[indexPath.row].name
        cell.imageView?.image = UIImage(named: planets[indexPath.row].image)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
