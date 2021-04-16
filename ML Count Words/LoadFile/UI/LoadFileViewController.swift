//
//  LoadFileViewController.swift
//  ML Count Words
//
//  Created by Ferran Rosales on 14/4/21.
//

import UIKit
import MobileCoreServices
import Lottie

class LoadFileViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let animationView = AnimationView()
    
    let scrollView = UIScrollView()
    let contentView = UIStackView()
    
    let header = UIView()
    let fromDevice = UIView()
    let fromCloud = UIView()
    let fromCloudContent = UIView()
    
    
    let headerImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "GrayBG")
        imageview.contentMode = .scaleToFill

        imageview.translatesAutoresizingMaskIntoConstraints = false
        
        return imageview
    }()
    
    let backButton: UIButton = {
        
        let button = UIButton()
        var image = UIImage(named: "ChevronBackWhite")
        
        
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.adjustsImageSizeForAccessibilityContentSizeCategory = true
        button.setTitle("   Volver", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //button.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        return button
        
    }()
    
    let headerBGImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "LoadHeaderImage")
        imageview.contentMode = .scaleToFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.heightAnchor.constraint(equalToConstant: 199).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 287).isActive = true
        return imageview
    }()
    
    let titleHeader: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cargar archivo"

        return label
        
    }()
    
    let fromDeviceButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Desde el dispositivo", for: .normal)
        button.backgroundColor = UIColor(named: "back_light_green")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(UIColor(named: "text_azul"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.layer.cornerRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(loadFile(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 86).isActive = true
        return button
        
    }()
    
    let fromDeviceButtonImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "device")
        imageview.contentMode = .scaleToFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 44).isActive = true
        return imageview
    }()
    
    let fromCloudLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "text_azul")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Desde la nube"

        return label
        
    }()
    
    let cloudImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "cloud")
        imageview.contentMode = .scaleToFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.heightAnchor.constraint(equalToConstant: 54).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 56).isActive = true
        return imageview
    }()
    
    let lineView: UIView = {
        let line = UIView()
        line.layer.borderWidth = 1.0
        line.layer.borderColor = UIColor(named: "text_azul")?.cgColor

        return line
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupContentView()
        setupHeader()
        setupFromDevice()
        setupFromCloud()
        setupAnimation()
        
    }
    
    private func setupAnimation() {
        animationView.animation = Animation.named("counting")
        animationView.backgroundColor = .white
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        
    }
    
    private func setupScrollView() {
        
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupContentView() {
        contentView.axis            = .vertical
        contentView.distribution    = .fill
        contentView.alignment       = .fill
        
        scrollView.addSubview(contentView)

        contentView.translatesAutoresizingMaskIntoConstraints = false


        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setupHeader() {
        
        header.addSubview(headerImageView)
        
        headerImageView.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        headerImageView.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: 2).isActive = true
        headerImageView.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        
        header.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: header.topAnchor, constant: 50).isActive = true
        backButton.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 15).isActive = true
        
        header.addSubview(headerBGImageView)
        headerBGImageView.topAnchor.constraint(equalTo: header.topAnchor, constant: 60).isActive = true
        headerBGImageView.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -18).isActive = true
        
        header.addSubview(titleHeader)
        titleHeader.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -15).isActive = true
        titleHeader.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16).isActive = true
        header.clipsToBounds = true
        
        contentView.addArrangedSubview(header)
        header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        
        
    }
    
    private func setupFromDevice() {
        
        fromDevice.addSubview(fromDeviceButton)
        fromDeviceButton.topAnchor.constraint(equalTo: fromDevice.topAnchor, constant: 36).isActive = true
        fromDeviceButton.leadingAnchor.constraint(equalTo: fromDevice.leadingAnchor, constant: 15).isActive = true
        fromDeviceButton.trailingAnchor.constraint(equalTo: fromDevice.trailingAnchor, constant: -15).isActive = true
        
        fromDeviceButton.addSubview(fromDeviceButtonImage)
        fromDeviceButtonImage.centerYAnchor.constraint(equalTo: fromDeviceButton.centerYAnchor).isActive = true
        fromDeviceButtonImage.trailingAnchor.constraint(equalTo: fromDeviceButton.trailingAnchor, constant: -20).isActive = true
        
        contentView.addArrangedSubview(fromDevice)
        fromDevice.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    private func setupFromCloud() {
        
        fromCloudContent.layer.cornerRadius = 10
        fromCloudContent.backgroundColor = UIColor(named: "back_light_green")
        fromCloudContent.layer.shadowOffset = CGSize(width: 0, height: 2)
        fromCloudContent.layer.shadowColor = UIColor.lightGray.cgColor
        fromCloudContent.layer.shadowOpacity = 1
        fromCloudContent.layer.shadowRadius = 4
        fromCloudContent.layer.masksToBounds = false
        fromCloud.addSubview(fromCloudContent)
        fromCloudContent.translatesAutoresizingMaskIntoConstraints = false
        
        fromCloudContent.heightAnchor.constraint(equalToConstant: 346).isActive = true
        fromCloudContent.leadingAnchor.constraint(equalTo: fromCloud.leadingAnchor, constant: 15).isActive = true
        fromCloudContent.trailingAnchor.constraint(equalTo: fromCloud.trailingAnchor, constant: -15).isActive = true
        
        fromCloudContent.addSubview(fromCloudLabel)
        fromCloudLabel.leadingAnchor.constraint(equalTo: fromCloud.leadingAnchor, constant: 30).isActive = true
        fromCloudLabel.topAnchor.constraint(equalTo: fromCloud.topAnchor, constant: 33).isActive = true
        
        fromCloudContent.addSubview(cloudImageView)
        cloudImageView.topAnchor.constraint(equalTo: fromCloud.topAnchor, constant: 16).isActive = true
        cloudImageView.trailingAnchor.constraint(equalTo: fromCloud.trailingAnchor, constant: -30).isActive = true
        
        fromCloudContent.addSubview(lineView)
        lineView.frame = CGRect(x: 25, y: 100, width: view.frame.width - 80, height: 1.0)
        lineView.topAnchor.constraint(equalTo: cloudImageView.bottomAnchor, constant: 20).isActive = true
        
        
        
        contentView.addArrangedSubview(fromCloud)
        fromCloud.heightAnchor.constraint(equalToConstant: 360).isActive = true
        fromCloud.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    @objc func back(sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func loadFile(sender: UIButton) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePlainText as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        present(documentPicker, animated: true, completion: {
            self.view.addSubview(self.animationView)
            self.animationView.play()
        })
        
    }
  

}

extension LoadFileViewController: UIDocumentPickerDelegate {
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        
        guard let selectedFileURL = urls.first else {
            return
        }
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            let stringText = try? String(contentsOf: sandboxFileURL, encoding: .utf8)
            let nameOfFile = sandboxFileURL.lastPathComponent
            goToCount(file: stringText!, name: nameOfFile)
            
        } else {
            do {
                
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                let stringText = try String(contentsOf: sandboxFileURL, encoding: .utf8)
                let nameOfFile = sandboxFileURL.lastPathComponent
                goToCount(file: stringText, name: nameOfFile)
            } catch  {
                print("Error: \(error)")
            }
        }
    }
    
    func goToCount(file: String, name: String) {
        let storyBoard = UIStoryboard(name: "WordCount", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WordCount") as! WordCountViewController
        vc.textOfFile = file
        vc.nameOfFile = name
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
