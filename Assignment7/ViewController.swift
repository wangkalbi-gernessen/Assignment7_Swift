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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let imageView2: UIImageView = {
        let imageName = "pizza_pockets"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let imageView3: UIImageView = {
        let imageName = "pop_tarts"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let imageView4: UIImageView = {
        let imageName = "popsicle"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let imageView5: UIImageView = {
        let imageName = "ramen"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
    var isShown: Bool = false // stackview
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // insert uiview into navigation bar
        setupNavigationUIView()
        setupStackView()
        
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#DDDDDD")
        addBtn.addTarget(self, action: #selector(addNewItem(_ :)), for: .touchUpInside)
        let barBtn: UIBarButtonItem = UIBarButtonItem(customView: addBtn)
        navigationItem.setRightBarButton(barBtn, animated: true)
        
        
    }
    
    // set up stackview for 5 images
    func setupStackView() {
        navigationUIView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: navigationUIView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: navigationUIView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo:  navigationUIView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: navigationUIView.trailingAnchor).isActive = true
    }
    
    // Reference are as follows:
    // https://stackoverflow.com/questions/49307990/animate-rotate-uibarbuttonitem-custom-buttons
    // https://stackoverflow.com/questions/25649926/trying-to-animate-a-constraint-in-swift/25650669
    // https://www.youtube.com/watch?app=desktop&v=GTPxE_J-jIY
    @objc func addNewItem(_ sender: UIButton) {
        
        isRotated = !isRotated
        isShown = !isShown
        
        heightConstraint.constant = isRotated ? 200.0 : 88.0
        
        
        UIView.animate(withDuration: 3.0, animations: {
//            let rotateTransform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
            let rotateTransform = CGAffineTransform(rotationAngle: 90 * .pi/180)
            sender.transform = rotateTransform
            self.navigationUIView.layoutIfNeeded()
        }, completion: nil)
        
        
//        let customView = sender
//
//        if self.isRotated == false {
//            self.navigationUIView.heightAnchor.constraint(equalToConstant: 88).isActive = false
//            self.navigationUIView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//            self.navigationUIView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//            self.navigationUIView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//            self.navigationUIView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//
//            UIView.animate(withDuration: 0.5, delay: 1.0, animations: {
//
////                let rotateTransform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
//                let rotateTransform = CGAffineTransform(rotationAngle: 90 * .pi/180)
//                customView.transform = rotateTransform
////                self.navigationUIView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
//
//
//
//
//            }, completion: {(_) in
//                self.isRotated = true
//            })
//        } else {
//            UIView.animate(withDuration: 0.5, delay: 1.0, animations: {
//                customView.transform = .identity
////
//
//                customView.transform = CGAffineTransform.identity
//
//            }, completion: {(_) in
//                self.isRotated = false
//
//            })
//        }
    }
    
    func setupNavigationUIView() {
        view.addSubview(navigationUIView)
        navigationUIView.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint.isActive = true
    }
}
