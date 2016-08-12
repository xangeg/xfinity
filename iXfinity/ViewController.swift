

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var btnSingIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSingIn.layer.cornerRadius = 5
        //btnSingIn.layer.borderWidth = 1
        //btnSingIn.layer.borderColor = UIColor.blackColor().CGColor
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func signInBtn(sender: AnyObject) {
        let postEndpoint: String = "https://96.119.82.129:443/SITestAgent/lg"
        let url = NSURL(string: postEndpoint)!
        let session = NSURLSession.sharedSession()
        let postParams : [String: AnyObject] = ["Session": session,"user":NSString(string: emailText.text!),"password":NSString(string:passwordText.text!)]
        // Create the request
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic d2VicGFfcmVsZWFzZTEuMA==", forHTTPHeaderField: "Authorization")
        
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postParams, options: NSJSONWritingOptions())
            print(NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding)!)
        } catch {
            print("bad things happened")
        }
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200
                
                else {
                    print("Not a 200 response for post")
                    return
            }
            
            // Read the JSON
            if let postString = NSString(data:data!, encoding: NSUTF8StringEncoding) as? String {
                // Print what we got from the call
                print("POST: " + postString)
                let post = "Done"
                print (post)
            }
        }).resume()
    }
    
    @IBAction func btnSignIn(sender: AnyObject) {
        print ("trial for commit")
        
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

