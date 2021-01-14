//
//  ViewController.swift
//  Assignment7
//
//  Created by Kazunobu Someya on 2021-01-13.
//

import UIKit

class ViewController: UIViewController {
    
    let navigationUIView: UIView = {
        let ngv = UIView()
        // Refer to "UIColor+NavigationBarColor.swift"
        ngv.backgroundColor = UIColor(hexString: "#DDDDDD")
        return ngv
    }()
    
    let addBtn: UIButton = {
        let add = UIButton(type: .system)
        add.setTitle("➕", for: .normal)
        return add
    }()
    
    let imageView1: UIImageView = {
        let imageName = "oreos"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return imageView
    }()
    
    let imageView2: UIImageView = {
        let imageName = "pizza_pockets"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return imageView
    }()
    
    let imageView3: UIImageView = {
        let imageName = "pop_tarts"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return imageView
    }()
    
    let imageView4: UIImageView = {
        let imageName = "popsicle"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return imageView
    }()
    
    let imageView5: UIImageView = {
        let imageName = "ramen"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView1,imageView2,imageView3,imageView4,imageView5])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    lazy var heightConstraint = navigationUIView.heightAnchor.constraint(equalToConstant: 88)
    var isRotated: Bool = false //
//    var isShown: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // insert uiview into navigation bar
        setupNavigationUIView()
        setupStackView()
        stackView.isHidden = true
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#DDDDDD")
        addBtn.addTarget(self, action: #selector(addNewItem(_ :)), for: .touchUpInside)
        let barBtn: UIBarButtonItem = UIBarButtonItem(customView: addBtn)
        navigationItem.setRightBarButton(barBtn, animated: true)
    }
    
    // set up stackview for 5 images
    func setupStackView() {
        navigationUIView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: navigationUIView.topAnchor, constant: heightConstraint.constant).isActive = true
        stackView.bottomAnchor.constraint(equalTo: navigationUIView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo:  navigationUIView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: navigationUIView.trailingAnchor).isActive = true
    }
    
    
    // Reference are as follows:
    // https://stackoverflow.com/questions/49307990/animate-rotate-uibarbuttonitem-custom-buttons
    // https://stackoverflow.com/questions/25649926/trying-to-animate-a-constraint-in-swift/25650669
    // https://www.youtube.com/watch?app=desktop&v=GTPxE_J-jIY
    @objc func addNewItem(_ sender: UIButton) {

// First solution
//        isRotated = !isRotated
//
//        heightConstraint.constant = isRotated ? 200.0 : 88.0
//        stackView.isHidden = isRotated ? false : true
//
//        UIView.animate(withDuration: 1.0, animations: {
//            let rotateTransform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
////            let rotateTransform = CGAffineTransform(rotationAngle: 90 * .pi/180)
//            sender.transform = rotateTransform
//            self.navigationUIView.layoutIfNeeded()
//        }, completion: nil)
        
        print(isRotated)
        // Second Solution
        let customView = sender
        if self.isRotated == false {
            
            UIView.animate(withDuration: 0.5, delay: 1.0, animations: {
//                let rotateTransform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
                let rotateTransform = CGAffineTransform(rotationAngle: 90 * .pi/180)
                customView.transform = rotateTransform
                self.heightConstraint.constant = 200
                self.stackView.isHidden = false
                self.isRotated = true
                print(self.isRotated)
            }, completion: nil)
//            }, completion: {(finished) in
//                self.isRotated = true
//            })
            
        } else {
            UIView.animate(withDuration: 0.5, delay: 1.0, animations: {
                customView.transform = CGAffineTransform.identity
//                let rotateTransform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi/4))
//                customView.transform = rotateTransform
                self.heightConstraint.constant = 88
                self.stackView.isHidden = true
                self.isRotated = false
                print(self.isRotated)
            }, completion: nil)
//            }, completion: {(_) in
//                self.isRotated = false
//
//            })
        }
    }
    
    func setupNavigationUIView() {
        view.addSubview(navigationUIView)
        navigationUIView.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint.isActive = true
        navigationUIView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navigationUIView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}