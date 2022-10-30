//
//  ViewController.swift
//  cinema-app
//
//  Created by FABRIZIO on 5/10/22.
//

import UIKit

class HomeViewController: UIViewController {

    private let sectionsTitle = ["Próximos estrenos", "Tendencia", "Recomendados para ti"]
    
    private let moviesTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemYellow
        view.addSubview(moviesTable)
        
        moviesTable.delegate = self
        moviesTable.dataSource = self
        
        let uiView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 700))
        let customView = FooterView()
        customView.frame = uiView.bounds /* add your frame */
        uiView.addSubview(customView)
        
        moviesTable.tableFooterView = uiView
    }

    //EVENTO QUE SE EJECUTA AL MOMENTO QUE SE AGREGAN SUBVIEWS
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //INSERTAR UN TABLEVIEW QUE OCUPA TODO EL ESPACIO DEL HOME VIEW
        moviesTable.frame = view.bounds
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - METODOS DE UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //MARK: - METODOS DE UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label: UILabel = UILabel(frame: view.frame)
        label.textColor = UIColor.white
        label.text = sectionsTitle[section]
        label.font = UIFont(name: "Helvetica Neue Bold", size: 25)

        return label
    }
    
}
