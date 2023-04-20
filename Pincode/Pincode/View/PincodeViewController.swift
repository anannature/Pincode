import UIKit

class PincodeViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var pincodeText: UITextField!
  var viewModel: PincodeViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = PincodeViewModel()
    viewModel?.delegate = self
    setUp()
  }
  
  func setUp() {
    pincodeText.layer.cornerRadius = 5
    pincodeText.layer.borderWidth = 1
    setPincodeDefault()
  }
}

extension PincodeViewController: UITextViewDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    viewModel?.pincode = string
    viewModel?.pincodeText = pincodeText.text ?? ""
      let setNumber = NSCharacterSet(charactersIn:"0123456789").inverted
      let stringComponents = string.components(separatedBy: setNumber)
      let filteredNumber = stringComponents.joined(separator: "")
    
      viewModel?.validateLengthOfMessage()
      return string == filteredNumber
  }
}

extension PincodeViewController: PincodeViewDelegate {
  func setPincodeDefault() {
    pincodeText.layer.borderColor = UIColor.lightGray.cgColor
    pincodeText.textColor = UIColor.black
  }
  
  func setPincodeFailed() {
    pincodeText.layer.borderColor = UIColor.red.cgColor
    pincodeText.textColor = UIColor.red
  }
}
