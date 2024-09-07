//
//  SecurityFunctions.swift
//  PassGuard
//

import Foundation

/// Scrambles the input value to be unreadable such that it can still be unscrambled
func Encrypt(_ value: String) -> String {
    var Encrypted_Value: String = ""
    if Check_Valid(value) == true {                                                             //Checking if the input value is valid
        
        for i in value {                                                                        //Looping through each character
            
            let val: Int = i.asciiValue                                                         //Finding the ascii value of the character
            
            if val == 126 {                                                                     //Checking if it is the last allowable character
                
                Encrypted_Value += String(UnicodeScalar(32)!)                                   //Apending the first allowable character (loop around)
            }
            else {
                
                Encrypted_Value += String(UnicodeScalar(val + 1)!)                              //Apending the next ascii value
            }
        }
    }
    else {
        Encrypted_Value = value                                                                 //Does not encrypt if input value is invalid
    }
    return Encrypted_Value                                                                      //Return the Encrypted Value
}

/// This is a function to unscramble a value so that it is readable again
func Decrypt (_ value: String) -> String {
    var Decrypted_Value: String = ""
    if Check_Valid(value) == true {                                                             //Checking if the input value is valid
        
        for i in value {                                                                        //Looping through each character
            
            let val: Int = i.asciiValue                                                         //Finding the ascii value of the character
            
            if val == 32 {                                                                      //Checking if it is the first allowable character
                
                Decrypted_Value += String(UnicodeScalar(126)!)                                  //Apending the last allowable character (loop back)
            }
            else {
                Decrypted_Value += String(UnicodeScalar(val - 1)!)                              //Apending previous ascii value
            }
        }
    }
    else {
        Decrypted_Value = value                                                                 //Does not encrypt if input value is invalid
    }
    return Decrypted_Value                                                                      //Return the Decrypted Value
}

/// Generates an unreadable string to preview a hidden version of a password
func getSecureString(_ input: String) -> String {
    let num = input.count                                                                       //Find the number of characters in the password
    var out = ""
    if num == 0 {
        return ""                                                                               //Return an empty string if the password is empty
    }
    for _ in 1...num {
        out += "•"                                                                              //Output the number of '•' as there are characters
    }
    return out
}

/// Generates a secure password
func generatePassword() -> String {
    var generatedPassword: [Character] = []
    var Password = ""
    var randInt = 0
    
    for _ in 1...10 {                                                                            //Gets a random lowercase letter
        randInt = Int.random(in: 97...122)
        generatedPassword += String(UnicodeScalar(randInt)!)
    }
    
    for _ in 1...5 {                                                                            //Gets a random uppercase letter
        randInt = Int.random(in: 65...90)
        generatedPassword += String(UnicodeScalar(randInt)!)
    }
    
    for _ in 1...5 {                                                                            //Gets a random integer
        randInt = Int.random(in: 48...57)
        generatedPassword += String(UnicodeScalar(randInt)!)
    }
    
    for _ in 1...3 {                                                                            //Gets a random special character (symbol)
        if Int.random(in: 0...1) == 1 {
            randInt = Int.random(in: 33...47)
            generatedPassword += String(UnicodeScalar(randInt)!)
        }
        else {
            randInt = Int.random(in: 58...64)
            generatedPassword += String(UnicodeScalar(randInt)!)
        }
    }
    
    generatedPassword.shuffle()                                                                 //Scramble the order of the characters
    
    for i in generatedPassword {                                                                //Convert the array of characters into a string
        Password += String(i)
    }
    
    return Password
}

/// Checks if the current user has any weak passwords (Strength below 5)
func HasWeakPassword() -> Bool {
    for card in Cards_Array {                                                                   //Goes through all cards in th application
        if card.Account_ID == ContentView().GLB_Account_Id {                                    //Looks at those which belong to the current user
            if card.passwordStrength < 5 {                                                      //Checks if any card has a password strength below 5
                return true                                                                     //Return true that the user has at least 1 weak password
            }
        }
    }
    return false                                                                                //Otherwise return false as user has no 'weak' passwords
}
