//
//  UserTableViewController.swift
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/18/24.
//

import UIKit

protocol UserSelectDelegate {
    func userChanged()  //Delegate function must update displayed user
}

class UserTableViewController: UITableViewController {
    //Modal view controller that displays a list of users to select from
    
    var delegate : UserSelectDelegate?
    
    lazy var userModel: UserModel = {
        return UserModel.sharedInstance()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userModel.getNumberOfUsers()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogoCell", for: indexPath) as! LogoTableViewCell
        
        // Logo cell setup
        cell.logoImage.layer.cornerRadius = 60
        cell.logoImage.layer.masksToBounds = true
        cell.logoImage.image = self.userModel.getUserImage(by: indexPath.row)
        cell.logoUsernameLabel.text = self.userModel.getUserBy(indexPath.row)
        cell.logoLevelLabel.text = self.userModel.getLevelBy(indexPath.row)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Call to model to update selected user
        self.userModel.setCurrentUserTo(indexPath.row)
        delegate?.userChanged();
        dismiss(animated: true)
    }

}
