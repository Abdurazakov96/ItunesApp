//
//  ViewController.swift
//  UrlApp
//
//  Created by Магомед Абдуразаков on 04/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    //MARK: Outlets
    
    @IBOutlet var button: UIButton!
    @IBOutlet var songLabel: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var barButtonNext: UIBarButtonItem!
    @IBOutlet var barButtonPrevious: UIBarButtonItem!
    
    
    //MARK: Public properties
    
    var indexOfMusic = 0
    var url = URL(string: "https://itunes.apple.com/search?term=")!
    var textfield: UITextField!
    
    
    // MARK: Overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfield = UITextField(frame: CGRect(x: 57, y: 200, width: 300, height: 50))
        textfield.backgroundColor = UIColor.red
        textfield.textColor = .black
        textfield.layer.cornerRadius = 25
        textfield.textAlignment = .center
        view.addSubview(textfield)
        
    }
    
    
    // MARK: IBActions
    
    @IBAction func searchMusic(_ sender: Any) {
        let itunesURL = "https://itunes.apple.com/search?term=" + textfield.text!
        url = URL(string: itunesURL)!
        
        loadRequest()
    }
    
    @IBAction func showNextMusicInformation(_ sender: Any) {
        guard indexOfMusic <= 49 else { barButtonNext.isEnabled = false
            return}
        indexOfMusic += 1
        loadRequest()
        barButtonPrevious.isEnabled = true
        print("next")
    }
    
    @IBAction func showPreviousMusicInformation(_ sender: Any) {
        guard indexOfMusic >= 1 else { barButtonPrevious.isEnabled = false
            return}
        indexOfMusic -= 1
        loadRequest()
        barButtonNext.isEnabled = true
        print("previous")
    }
    
    
    //MARK: Public methods
    
    func loadRequest(){
        _ = URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else  {return}
            let decoder = JSONDecoder()
            guard var value = try? decoder.decode(Singer.self, from: data) else {return}
            print(value)
            self.navigationItem.title = value.results[self.indexOfMusic].artistName
            self.songLabel.text = value.results[self.indexOfMusic].trackName
            print(value)
            
            DispatchQueue.main.async {
                URLSession.shared.dataTask(with: value.results[self.indexOfMusic].artworkUrl100) {imageData,_,_ in
                    guard let imageData = imageData else {return}
                    self.image.image = UIImage(data: imageData as Data)
                    }.resume()
            }
    
            }.resume()
    }
    
}
