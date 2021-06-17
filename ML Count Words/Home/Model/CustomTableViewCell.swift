//
//  CustomTableViewCell.swift
//  ML Count Words
//
//  Created by Ferran Rosales on 14/4/21.
//

import UIKit
import Lottie

class CustomTableViewCell: UITableViewCell {
    
    var animationView = AnimationView()
    
    let imageCell: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "file_icon")

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        return imageView
    }()
    
    let chevron: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chevron_right")

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        return imageView
    }()
    
    let filename: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: "text_azul")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "File name"

        return label
    }()
    let numberOfWords: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(named: "text_azul")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "125 palabras"

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        contentView.backgroundColor = UIColor(named: "back_light_green")
        
        
        contentView.addSubview(imageCell)
        imageCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        imageCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        
        contentView.addSubview(filename)
        filename.centerYAnchor.constraint(equalTo: imageCell.centerYAnchor).isActive = true
        filename.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 16).isActive = true
        filename.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -100).isActive = true
        
//        contentView.addSubview(numberOfWords)
//        numberOfWords.topAnchor.constraint(equalTo: filename.bottomAnchor, constant: 7).isActive = true
//        numberOfWords.leadingAnchor.constraint(equalTo: filename.leadingAnchor).isActive = true
        
        contentView.addSubview(chevron)
        chevron.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        chevron.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAnimationView() {
        
        
        
        animationView.animation = Animation.named("counting")
        animationView.backgroundColor = .white
        //animationView.frame
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        contentView.addSubview(animationView)
        animationView.play()
        

        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
