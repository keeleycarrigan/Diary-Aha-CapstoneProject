enum ValidationError: Error {
    case emptyField(String)
    case invalidFormat(String)
    case exceedsMaxLength(String, Int)

    var localizedDescription: String {
        switch self {
        case .emptyField(let fieldName):
            return "\(fieldName) cannot be empty"
        case .invalidFormat(let message):
            return message
        case .exceedsMaxLength(let fieldName, let maxLength):
            return "\(fieldName) cannot exceed \(maxLength) characters"
        }
    }
}
