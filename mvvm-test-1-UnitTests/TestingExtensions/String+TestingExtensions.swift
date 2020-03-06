import Foundation

extension String {
    var characterNumber: Int {
        return Int(characterURLNumber())!
    }
    
    private func characterURLNumber() -> String {
        let start = self.index(self.endIndex, offsetBy: -3)
        let end = self.index(self.endIndex, offsetBy: -1)
        let range = start..<end
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: String(self[range]))) {
            return String(self[range])
        } else {
            let start = self.index(self.endIndex, offsetBy: -2)
            let end = self.index(self.endIndex, offsetBy: -1)
            let range = start..<end
            return String(self[range])
        }
    }
}
