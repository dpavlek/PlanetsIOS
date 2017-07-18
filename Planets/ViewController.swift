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
        
        tableView.delegate = self
        tableView.dataSource = self

        for item in items {
            var planetName = item
            if let startIndex = item.range(of: "."){
                planetName.removeSubrange(startIndex.lowerBound..<item.endIndex)
            }
            
            planetName = planetName.replacingOccurrences(of: "planet_", with: "").capitalized
            
            if item.hasPrefix("planet") {
                planets.append(Planet(name: planetName, image: item))
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
            fatalError("Cell is not PlanetTableViewCell")
        }
        cell.planetLabel?.text = planets[indexPath.row].name
        cell.planetImage?.image = UIImage(named: planets[indexPath.row].image)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.isHidden = true
    }*/

}
