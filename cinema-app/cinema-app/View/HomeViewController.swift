//
//  ViewController.swift
//  cinema-app
//
//  Created by FABRIZIO on 5/10/22.
//

import UIKit

class HomeViewController: UIViewController {

    private let moviesTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemYellow
        view.addSubview(moviesTable)
        
        moviesTable.delegate = self
        moviesTable.dataSource = self
        
        
    }

    //EVENTO QUE SE EJECUTA AL MOMENTO QUE SE AGREGAN SUBVIEWS
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //INSERTAR UN TABLEVIEW QUE OCUPA TODO EL ESPACIO DEL HOME VIEW
        moviesTable.frame = view.bounds
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "My text"
        return cell
    }
    
    
}
