//
//  CategoriesTableViewController.swift
//  iQuiz
//
//  Created by Trevor Allen on 5/4/16.
//  Copyright © 2016 Trevor Allen. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    @IBAction func settings(sender: UIBarButtonItem) {
        let settingsVC : SettingsViewController = storyboard?.instantiateViewControllerWithIdentifier("Settings") as! SettingsViewController
        settingsVC.modalPresentationStyle = .Popover
        settingsVC.preferredContentSize = CGSizeMake(400, 130)
        
        let popoverPresentationViewController = settingsVC.popoverPresentationController
        popoverPresentationViewController?.permittedArrowDirections = .Any
        popoverPresentationViewController?.delegate = self
        popoverPresentationViewController?.barButtonItem = sender
        presentViewController(settingsVC, animated: true, completion: nil)
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle{
        return .None
    }
    
    private let icons : [String] = ["math.jpg", "science.png", "marvel.jpeg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        QuizManager.Instance.DownloadData() {
           self.tableView.reloadData()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return QuizManager.Instance.quizzes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryTableViewCell

        cell.icon.image = UIImage(named: icons[indexPath.row])
        let quiz = QuizManager.Instance.quizzes[indexPath.row] as! Quiz
        cell.title.text = quiz.title
        cell.desc.text = quiz.description
        cell.icon.image = UIImage(named: icons[indexPath.row])
        return cell
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        QuizManager.Instance.startQuiz(indexPath.row)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
