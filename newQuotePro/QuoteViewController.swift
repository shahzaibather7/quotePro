//
//  ViewController.swift
//  newQuotePro
//
//  Created by Mohammad Shahzaib Ather on 2017-08-30.
//  Copyright © 2017 Mohammad Shahzaib Ather. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
       
        return imageView
    }()
    
    let quoteLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = UIColor.white
        label.numberOfLines = 6
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    
    
    lazy var randomQuotebutton : UIButton = {
        let button = UIButton(type:.system)
        button.backgroundColor = UIColor.purple
        button.setTitle("Quote", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(useJSON), for: .touchUpInside)
        return button
    }()
    
    lazy var randomPicbutton : UIButton = {
        let button = UIButton(type:.system)
        button.backgroundColor = UIColor.purple
        button.setTitle("Picture", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(useJSONPic), for: .touchUpInside)
        return button
    }()
    
//View did load 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
        self.view.addSubview(randomQuotebutton)
        self.view.addSubview(randomPicbutton)
        self.view.backgroundColor = UIColor.white
        
        
        setupImageViewConstraints()
        setupQuoteButtonConstraints()
        setupPictureButtonConstraints()
        setupQuoteLabelConstraints()
    }


    func useJSONPic(){

        let pictureURL = URL(string: "http://lorempixel.com/200/300/")
        let session = URLSession(configuration: .default)
        let getImageFromURL = session.dataTask(with: pictureURL!){ (data , response , error) in
            
            if error != nil {
               print("Error ")
            } else {
                if (response as? HTTPURLResponse) != nil {
                    if let imageData = data {
                        DispatchQueue.main.sync {

                        let image = UIImage(data: imageData)
                        self.imageView.image = image
                        }
                    } else {
                        print("No image found")
                          }
                    
                }   else {
                    print("No response from server")
                         }
           
            }
            
        }
        
        getImageFromURL.resume()
    }
//Prints Quote but doesnt display
    
    func useJSON(){

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")!

        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        DispatchQueue.main.sync {
                            
                                self.quoteLabel.text = json["quoteText"] as! String?
                        }
                                                
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
                
                
            }
            
        })
        task.resume()
        
    }
    
    
//Manual Constraints for buttons and imageview
    
    func setupImageViewConstraints() {
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3, constant: -15).isActive = true
        imageView.addSubview(quoteLabel)
       
    }
    
    func setupQuoteButtonConstraints() {
        randomQuotebutton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        randomQuotebutton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        randomQuotebutton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        randomQuotebutton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupPictureButtonConstraints() {
        randomPicbutton.leftAnchor.constraint(equalTo: randomQuotebutton.rightAnchor, constant: 20).isActive = true
        randomPicbutton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        randomPicbutton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        randomPicbutton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func setupQuoteLabelConstraints() {
       
        quoteLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 20).isActive = true
        quoteLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 40).isActive = true
        quoteLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -20).isActive = true
        quoteLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
  
        

    }
}

 
