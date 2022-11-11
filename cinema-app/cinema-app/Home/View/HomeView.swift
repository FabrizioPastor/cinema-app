//
//  ViewController.swift
//  cinema-app
//
//  Created by FABRIZIO on 5/10/22.
//

import UIKit

class HomeView: UIViewController {

    //MARK: - Atributos
    private let sectionsTitle = ["Próximos estrenos", "Tendencia", "Recomendados para ti"]
    
    private let moviesTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: - Métodos de clase
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        view.addSubview(moviesTable)
        
        moviesTable.delegate = self
        moviesTable.dataSource = self
        
        let uiView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 700))
        let customView = ForYouFooterView()
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
    
    //MARK: - Métodos de usuario
    private func configureView() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "e-movie-icon")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
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
        
        var categoria: APICaller.categoryEnum?
        
        switch indexPath.section {
        case APICaller.categoryEnum.trendingMovies.rawValue:
            categoria = .trendingMovies
        case APICaller.categoryEnum.upcomingMovies.rawValue:
            categoria = .upcomingMovies
        case APICaller.categoryEnum.topRated.rawValue:
            categoria = .topRated
        default:
            break
        }
        
        guard let categoria = categoria else { return cell }
        
        APICaller.shared.getDataFrom(category: categoria) { results in
            switch results {
            case .success(let titles):
                cell.configure(with: titles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
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
