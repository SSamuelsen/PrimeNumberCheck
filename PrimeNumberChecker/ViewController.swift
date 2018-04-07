//
//  ViewController.swift
//  PrimeNumberChecker
//
//  Created by Stephen Samuelsen on 3/22/18.
//  Copyright © 2018 Stephen Samuelsen. All rights reserved.
//

import UIKit



final class ViewController: UIViewController {

    
    @IBOutlet weak var numberInputField: UITextField!
    @IBOutlet weak var primeCheckButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var isPrimeLabel: UILabel!
    @IBOutlet weak var arrayOfBadChars: UILabel!        //used to provide show the user which symbols are illegal
    
    
    
    let numberSet = ["0","1","2","3","4","5","6","7","8","9"]   //this is the array that the input text is going to be compared against...
                                                                //in order to ensure that the input is of type int
    
    
    
    var joinedSumString = ""
    //var checkedNumberString: String = ""            //used to story the String array
    //var checkedNumberInt: Int = 0                   //used to convert the string array to an Int
    var isPrime: Bool = false                   //true is prime, false if not prime
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberInputField.keyboardType = UIKeyboardType.numberPad        //restricts it so that only number pad will show up
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
     
    }
    
    
    
    
    func checkIfNumber() throws -> Int {                  //function used to check if the user input is a valid integer //returns Int
        
        if (numberInputField.text?.isEmpty != true) {       //check to see if the input field is not empty
        
        guard let number = numberInputField.text else {return 0}      //assign var to the value of numberInputField if it is not null
        
        let newNumArray = number.flatMap{(String($0))}      //this turns the value that is in the text into an array made up of all the individuals letters and or digits
        
        
        var invalidated = false
        var intArray = [Int]()              //holds all the valid integers entered
        var badArray = [String]()           //holds the illegal characters
        
        
            
                
        
        newNumArray.forEach({element in     //forEach function loops through each element in the new array created by the flatMap method
            
            if(invalidated != true) {       //makes sure that if the text contains even one non number, the loop stops and the value will not be accepted
                
                
                let char:String = String(element)       //need to convert to a string for it to work
                
                //var convertToInt: Int
                
                
                if (numberSet.contains(char)){   //checks to see if the numberSet Array contains the element
                    
                    errorLabel.isHidden = true
                    
                    
                        
                    guard let convertToInt = Int(String(element)) else {return}        //converts the element to an int            //avoids force unwrap
                    intArray.append(convertToInt)               //adds the element to a new array
                    arrayOfBadChars.text = ""
                    arrayOfBadChars.isHidden = true
                        
                        
                   
                    
                    
                    
                    
                }
                    
                else  {
                    
                    invalidated = true                          //stops the loop
                    errorLabel.text = "Please enter an integer"
                    errorLabel.isHidden = false                         //stops the loop
                    badArray.append(String(element))
                    let num = badArray.count                                        //counts how many elements are in the array
                    arrayOfBadChars.text = "Not an integer: \(badArray[0..<num])"       //displays all the elements that are integers
                    arrayOfBadChars.isHidden = false
                    
                    
                }
                
                
                
                
            }
            else {
                
                errorLabel.text = "Please enter an integer"
                errorLabel.isHidden = false
                badArray.append(String(element))
                let num = badArray.count
                arrayOfBadChars.text = "Not an integer: \(badArray[0..<num])"
                arrayOfBadChars.isHidden = false
                
            }
            
            
            
            
            
            
            
            
            
        })
            //end of forEach loop
        
        
        //code to test of if the number is prime
        //first must add the entire array
        
        
        
        let sumString = intArray.map {String($0) }              //converts the array to an array of strings
        
                
        joinedSumString = sumString.joined()        //set variable to a joined string array connecting all the numbers together into one value
        
        
        //checkedNumberString = joinedSumString
        
        if joinedSumString.isEmpty != true {
        
            guard let checkedNumberInt = (Int(joinedSumString)) else {return 0}          //this is the value that will then be checked to see if it is prime
            return checkedNumberInt             //returns the integer
        }
        
            
        
            
        
        }
        return 0;
        
    }//end of function
    
    
    
    func checkIfPrime(number: Int) {                //function to check whether number is prime or not
        
                                                                                        //$0 first parameter passed into the closure
        isPrime = ((number > 1) && (!(2..<number).contains {number % $0 == 0}))       //this checks to see if number is greater than 1 because 0 and 1 are both not prime
                                                                                //then checks to see if each number in the range of numbers leaves remainder after being divided by each number in the range defined
        
        if ((isPrime == true)&&(numberInputField.text?.isEmpty != true)) {
            
            isPrimeLabel.text = "Prime"
            
        }
        
        if ((isPrime != true)&&(numberInputField.text?.isEmpty != true)) {
            
            isPrimeLabel.text = "Not Prime"
            
        }
        
        if ((numberInputField.text?.isEmpty == true)) {             //sets the label to blank if there is nothing in the text field
            isPrimeLabel.text = ""
        }
        
        
        
        
        
    }//end of check if Prime Function
    
   
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)                              //hides keyboard when clicking outside of it
        
    }
    
    
    
    
    
    @IBAction func primeCheckButtonPressed(_ sender: Any) {
        
        
        guard let checkedNumber = try? checkIfNumber() else {return}
        
       checkIfPrime(number: checkedNumber)
        
        
        
        
        
        
    }//end of the buttonPressed function
    
    
    
    
    
    
    
    


}

