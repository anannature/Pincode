import Foundation

protocol PincodeViewDelegate: AnyObject {
  func setPincodeDefault()
  func setPincodeFailed()
}
class PincodeViewModel {
  var delegate: PincodeViewDelegate?
  var pincode: String?
  var pincodeText: String?
  
  func validateLengthOfMessage() {
    if pincodeText?.count ?? 0 < 5 {
      delegate?.setPincodeFailed()
    }
    
    else {
      validateNumberDuplicateCharacters()
    }
  }
  
  func validateNumberDuplicateCharacters() {
    var number:[Int] = []
    
    pincodeText?.forEach { char in
      let filter = pincodeText?.filter({$0 >= char})
      
      number.append(Int(String(char)) ?? 0)
     let chatToInt = Int(String(char))
      let filterNumber = number.filter({$0 > ((chatToInt ?? 0)+1) || $0 < ((chatToInt ?? 0)-1)})
      
      if filter?.count ?? 0 > 1 {
        delegate?.setPincodeFailed()
        let checkPincode = pincode?.filter({$0 != char})
        if checkPincode?.count ?? 0 >= 1 {
          delegate?.setPincodeDefault()
          if filterNumber.count < 4 {
            delegate?.setPincodeFailed()
          }
        }
      } else {
        delegate?.setPincodeDefault()
          let checkPincode = pincode?.filter({$0 != char})
          if checkPincode?.count ?? 0 > 1 {
            delegate?.setPincodeFailed()
          }
        print(filterNumber.count)
          if filterNumber.count >= 4 {
            delegate?.setPincodeDefault()
            return
          } else {
            delegate?.setPincodeFailed()
          }
        }
      }    
  }
}
