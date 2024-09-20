//
//  UserTableViewController.swift
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/18/24.
//

import UIKit

protocol UserSelectDelegate {
    //func changeUserFor(index : Int)
    func userChanged()
}

class UserTableViewController: UITableViewController {
    
    var delegate : UserSelectDelegate?
    
    lazy var userModel: UserModel = {
        return UserModel.sharedInstance()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.userModel.getNumberOfUsers()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogoCell", for: indexPath) as! LogoTableViewCell
        
        cell.logoImage.layer.cornerRadius = 60
        cell.logoImage.layer.masksToBounds = true
        cell.logoImage.image = self.userModel.getUserImage(by: indexPath.row)
        cell.logoUsernameLabel.text = self.userModel.getUserBy(indexPath.row)
        cell.logoLevelLabel.text = self.userModel.getLevelBy(indexPath.row)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.userModel.setCurrentUserTo(indexPath.row)
        delegate?.userChanged();
        //delegate?.changeUserFor(index: indexPath.row)
        dismiss(animated: true)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
