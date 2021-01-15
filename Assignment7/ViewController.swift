//
//  ViewController.swift
//  Assignment7
//
//  Created by Kazunobu Someya on 2021-01-13.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let navigationUIView: UIView = {
        let ngv = UIView()
        // Refer to "UIColor+NavigationBarColor.swift"
        ngv.backgroundColor = UIColor(hexString: "#DDDDDD")
        return ngv
    }()
    
    let addBtn: UIButton = {
        let add = UIButton(type: .system)
        add.setTitle("+", for: .normal)
        add.setTitleColor(.systemBlue, for: .normal)
        add.titleLabel?.font = UIFont(name: "Georgia", size: 40)
        return add
    }()
    
    // Reference is https://stackoverflow.com/questions/39646049/swift-button-background-image-not-appearing
    // When I add background image to uibuttons, I used above referen
    let imageView1: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "oreos")
        btn.setBackgroundImage(image, for: .normal)
        btn.tag = 0
        btn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btn.addTarget(self, action: #selector(insertButtonsToImageView(_:)), for: .touchUpInside)
        return btn
    }()
    
    let imageView2: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "pizza_pockets")
        btn.setBackgroundImage(image, for: .normal)
        btn.tag = 1
        btn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btn.addTarget(self, action: #selector(insertButtonsToImageView(_:)), for: .touchUpInside)
        return btn
    }()
    
    let imageView3: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "pop_tarts")
        btn.setBackgroundImage(image, for: .normal)
        btn.tag = 2
        btn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btn.addTarget(self, action: #selector(insertButtonsToImageView(_:)), for: .touchUpInside)
        return btn
    }()
    
    let imageView4: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "popsicle")
        btn.setBackgroundImage(image, for: .normal)
        btn.tag = 3
        btn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btn.addTarget(self, action: #selector(insertButtonsToImageView(_:)), for: .touchUpInside)
        return btn
    }()
    
    let imageView5: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "ramen")
        btn.setBackgroundImage(image, for: .normal)
        btn.tag = 4
        btn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btn.addTarget(self, action: #selector(insertButtonsToImageView(_:)), for: .touchUpInside)
        return btn
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
    
    let tableView: UITableView = {
        let tbv = UITableView()
        return tbv
    }()
    
    lazy var heightConstraint = navigationUIView.heightAnchor.constraint(equalToConstant: 44)
    lazy var topAnchorConstraint = myTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44)
    var isRotated: Bool = false //
    var myTableView: UITableView!
    var cellId = "cell"
    
    // I made following empty array to append new image name per a click
    var tableViewSnacks = [String]()
    var snacks = ["oreos","pizza_pockets","pop_tarts","popsicle","ramen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // insert uiview into navigation bar
        setupNavigationUIView()
        setupStackView()
        stackView.isHidden = true
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#DDDDDD")
        title = "SNACKS"
        addBtn.addTarget(self, action: #selector(addNewItem(_ :)), for: .touchUpInside)
        let barBtn: UIBarButtonItem = UIBarButtonItem(customView: addBtn)
        navigationItem.setRightBarButton(barBtn, animated: true)
        setupUITableView()
    }
    
    // when buttons are clicked, image name appear on tableview cell
    @objc func insertButtonsToImageView(_ sender : UIButton) {
        if sender.tag == 0 {
            self.tableViewSnacks.append(snacks[0])
        } else if sender.tag == 1 {
            self.tableViewSnacks.append(snacks[1])
        } else if sender.tag == 2 {
            self.tableViewSnacks.append(snacks[2])
        } else if sender.tag == 3 {
            self.tableViewSnacks.append(snacks[3])
        } else {
            self.tableViewSnacks.append(snacks[4])
        }
        myTableView.reloadData()
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
        // Second Solution
        let customView = sender
        if self.isRotated == false {
            title = "Add a SNACK"
            UIView.animate(withDuration: 3.0, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, animations: {
                let rotateTransform = CGAffineTransform(rotationAngle: .pi / 3.7)
                customView.transform = rotateTransform
                self.heightConstraint.constant = 200
                self.topAnchorConstraint.constant = 200
                self.stackView.isHidden = false
                self.view.layoutIfNeeded()
            }, completion: {(finished) in
                self.isRotated = true
            })
        } else {
            title = "SNACK"
            UIView.animate(withDuration: 3.0, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, animations: {
                let rotateTransform = CGAffineTransform(rotationAngle: .pi / 2)
                customView.transform = rotateTransform
                self.heightConstraint.constant = 44
                self.topAnchorConstraint.constant = 44
                self.stackView.isHidden = true
                self.view.layoutIfNeeded()
            }, completion: {(_) in
                self.isRotated = false
            })
        }
    }
    
    func setupNavigationUIView() {
        view.addSubview(navigationUIView)
        navigationUIView.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint.isActive = true
        navigationUIView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navigationUIView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func setupUITableView() {
        myTableView = UITableView()
        self.view.addSubview(myTableView)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        myTableView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myTableView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        topAnchorConstraint.isActive = true
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        myTableView.dataSource = self
        myTableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSnacks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "\(tableViewSnacks[indexPath.row])"
        return cell
    }
}
