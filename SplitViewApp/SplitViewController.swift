//
//  ViewController.swift
//  SplitViewApp
//
//  Created by Nadeem Ahmad on 16/10/23.
//

import UIKit

class SplitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Feature branch changes
        // Feature branch changes 2

        
        let button  =  UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        button.center = self.view.center
        button.setTitle("Open Split View ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        
        button.addTarget(self,action: #selector(setupSplitView), for: .touchUpInside)
        
        view.addSubview(button)
        
        modalPresentationStyle = .fullScreen
    }
    
    @objc func setupSplitView() {
        
        let splitViewController = UISplitViewController(style: .doubleColumn)
        
        let lisController =  TableListViewController(style: .plain)
        let detailController  = DetailViewController()
        lisController.delgate = detailController
        
        splitViewController.modalPresentationStyle = .fullScreen
        splitViewController.viewControllers  = [UINavigationController(rootViewController: lisController),UINavigationController(rootViewController:detailController)]
        present(splitViewController, animated: true)
        
    }
    

}

class TableListViewController : UITableViewController {
    
    // Feature branch changes 3

    weak var delgate:DetailViewController?
    
    let employeeArray =  [Employee(name: "Nadeem", profession: "Engineer",photo:UIImage(systemName: "star")),
                          Employee(name: "Rahul", profession: "Doctor",photo:UIImage(systemName: "star")),
                          Employee(name: "Suman", profession: "Mechanic",photo:UIImage(systemName: "star")),
                          Employee(name: "Vinay", profession: "Servant",photo:UIImage(systemName: "star"))]
    
    override init(style: UITableView.Style) {
        
        super.init(style: style)
        
        title = "Menu"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return employeeArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell  =    tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let employee  =  employeeArray[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text =  employee.name
        content.secondaryText =  employee.profession
        content.image =  employee.photo
        cell.contentConfiguration =  content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let employee  =  employeeArray[indexPath.row]

        self.delgate?.didTap(employee.name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    
}

protocol SplitViewDidSelect {
    
    func didTap(_ value:String)
    
}

class DetailViewController : UIViewController,SplitViewDidSelect {
   
    var label:UILabel!;
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "DetailView"
    
        label  =  UILabel()
        label.frame = CGRect(x: 0, y: 0, width:400, height: 50)
        label.center = view.center
        label.textColor = .blue
        view.bringSubviewToFront(label)
        view.addSubview(label)

    
    }
    
    func didTap(_ value: String) {
        
        label.text =  value
        view.backgroundColor = .red
    }
}

struct Employee {
    
    var name:String;
    var profession:String
    var photo:UIImage?
    
}

