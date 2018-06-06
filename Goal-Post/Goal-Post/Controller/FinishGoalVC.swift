//
//  FinishGoalVC.swift
//  Goal-Post
//
//  Created by Sawadogo Thierry on 6/2/18.
//  Copyright © 2018 Sawadogo Thierry. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    //var to hold the values
    var goalDescription: String!
    var goalType: GoalType!
    
    func intiData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self

        
    }

    
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        
        if pointsTextField.text != "" {
            
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
            
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismissDetail()
    }
    
    
    
    //pour save les data dan coreData la
    func save(completion: (_ finished: Bool) -> ()) {
        
        guard let managerContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: managerContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managerContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
}








