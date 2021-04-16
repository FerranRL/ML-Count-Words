//
//  ListOfWordsTableViewCell.swift
//  ML Count Words
//
//  Created by Ferran Rosales on 16/4/21.
//

import UIKit

class ListOfWordsTableViewCell: UITableViewCell {
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: "text_azul")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "File name"
        
        return label
    }()
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "125 palabras"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wordLabel)
        wordLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        wordLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16).isActive = true
        
        contentView.addSubview(numberLabel)
        numberLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 7).isActive = true
        numberLabel.leadingAnchor.constraint(equalTo: wordLabel.leadingAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


