//
//  HomeViewController.swift
//  ML Count Words
//
//  Created by Ferran Rosales on 13/4/21.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var animationView = AnimationView()
    
    let contentView = UIStackView()
    
    let header = UIView()
    let recents = UIView()
    let whiteView = UIView()
    
    let tableview = UITableView()
    
    var fakeData = ["Uno", "Dos", "Tres"]
    
    var namesData:[String] = []
    var stringsData:[String] = []
    
    var textOfFile = ""
    var numberOfWords:[Int] = []
    
    let headerImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "home_header")
        imageview.contentMode = .scaleToFill

        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let homeImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "home_image")
        imageview.contentMode = .scaleToFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.heightAnchor.constraint(equalToConstant: 128).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 111).isActive = true
        return imageview
    }()
    
    
    let bienvenido: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bienvenido"

        return label
        
    }()
    
    let bienvenidoSub: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Encuentra y cuenta palabras"

        return label
        
    }()
    
    let archivosRecientes: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "text_azul")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Archivos Recientes"

        return label
        
    }()
    
    let loadNewFileButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = UIColor(named: "text_azul")
        button.setTitle("Cargar nuevo archivo", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 8
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(loadFile(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFolderNames()
        setupContentView()
        setupHeader()
        setupRecents()
        setupTableView()
        
        
  
    }
    
    private func setupAnimationView() {
        
        contentView.addSubview(whiteView)
        whiteView.frame = view.bounds
        whiteView.backgroundColor = .white
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        
        animationView.animation = Animation.named("counting")
        animationView.backgroundColor = .white
        animationView.frame = self.view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        whiteView.addSubview(animationView)
        
        

        

    }
    
    private func playAnimation() {
        print("Entramos en la funcion de animacion")
        tableview.addSubview(animationView)
        animationView.play()
    }
    
    private func setupFolderNames() {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        guard let directoryURL = URL(string: paths.path) else {return}
        do {
           let contents = try
           FileManager.default.contentsOfDirectory(at: directoryURL,
                  includingPropertiesForKeys:[.contentModificationDateKey],
                  options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
               .filter { $0.lastPathComponent.hasSuffix("") }
               .sorted(by: {
                   let date0 = try $0.promisedItemResourceValues(forKeys:[.contentModificationDateKey]).contentModificationDate!
                   let date1 = try $1.promisedItemResourceValues(forKeys:[.contentModificationDateKey]).contentModificationDate!
                return date0.compare(date1) == .orderedDescending
                })
            
            for item in contents {
                guard (try? item.promisedItemResourceValues(forKeys:[.contentModificationDateKey]).contentModificationDate) != nil
                    else {return}
                namesData.append(item.lastPathComponent)
            }

        } catch {
            print (error)
        }
        
    }
    
    private func setupContentView() {
        contentView.axis = .vertical
        contentView.distribution = .fill
        contentView.alignment = .fill
        contentView.backgroundColor = .white
        view.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        }
    
    private func setupHeader() {
        
        header.addSubview(headerImageView)
        headerImageView.topAnchor.constraint(equalTo: header.topAnchor, constant: -5).isActive = true
        headerImageView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: -6).isActive = true
        headerImageView.heightAnchor.constraint(equalTo: header.heightAnchor).isActive = true
        
        header.addSubview(homeImageView)
        homeImageView.topAnchor.constraint(equalTo: header.topAnchor, constant: 55).isActive = true
        homeImageView.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        

        
        header.addSubview(bienvenido)
        
        bienvenido.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -37).isActive = true
        bienvenido.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 15).isActive = true
        
        header.addSubview(bienvenidoSub)
        bienvenidoSub.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -20).isActive = true
        bienvenidoSub.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 15).isActive = true
        
        header.clipsToBounds = true
        contentView.addArrangedSubview(header)
        header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
    }
    private func setupRecents() {
        
        recents.addSubview(archivosRecientes)
        archivosRecientes.topAnchor.constraint(equalTo: recents.topAnchor, constant: 30).isActive = true
        archivosRecientes.leadingAnchor.constraint(equalTo: recents.leadingAnchor, constant: 15).isActive = true
        
        recents.addSubview(loadNewFileButton)
        loadNewFileButton.bottomAnchor.constraint(equalTo: recents.bottomAnchor, constant: -60).isActive = true
        loadNewFileButton.leadingAnchor.constraint(equalTo: recents.leadingAnchor, constant: 15).isActive = true
        loadNewFileButton.trailingAnchor.constraint(equalTo: recents.trailingAnchor, constant: -15).isActive = true
        
        contentView.addArrangedSubview(recents)
        
        recents.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3).isActive = true
        
    }
    
    private func setupTableView() {
        
        
        recents.addSubview(tableview)
        tableview.backgroundColor = .white
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: archivosRecientes.bottomAnchor, constant: 25).isActive = true
        tableview.leadingAnchor.constraint(equalTo: recents.leadingAnchor, constant: 15).isActive = true
        tableview.trailingAnchor.constraint(equalTo: recents.trailingAnchor, constant: -15).isActive = true
        tableview.bottomAnchor.constraint(equalTo: loadNewFileButton.topAnchor, constant: -25).isActive = true
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.separatorStyle = .none
        
    }
    
    @objc private func menu(sender: UIButton) {
        print("Menu tapped")
    }
    
    @objc private func loadFile(sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "LoadFile", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LoadFile")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if namesData.count <= 3 {
            return namesData.count
        } else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.selectionStyle = .none
        cell.filename.text = namesData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            self.setupAnimationView()
        }
        
            print("iniciamos el proceso")
            self.setupAnimationView()
            let storyBoard = UIStoryboard(name: "WordCount", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "WordCount") as! WordCountViewController
            vc.nameOfFile = self.namesData[indexPath.row]
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion:{
                self.animationView.removeFromSuperview()
            })
        
       
    }
}

