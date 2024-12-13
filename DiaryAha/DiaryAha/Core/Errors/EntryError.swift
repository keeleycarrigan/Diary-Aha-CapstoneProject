enum EntryError: Error {
    case invalidDate
    case invalidImage
    case invalidTitle
    case invalidBody
    case saveFailed(Error)
    case deleteFailed(Error)
    case photoProcessingFailed(Error)

    var localizedDescription: String {
        switch self {
        case .invalidDate:
            return "Invalid date provided"
        case .invalidImage:
            return "Invalid image format or corrupted image data"
        case .invalidTitle:
            return "Entry title cannot be empty"
        case .invalidBody:
            return "Entry body cannot be empty"
        case .saveFailed(let error):
            return "Failed to save entry: \(error.localizedDescription)"
        case .deleteFailed(let error):
            return "Failed to delete entry: \(error.localizedDescription)"
        case .photoProcessingFailed(let error):
            return "Failed to process photo: \(error.localizedDescription)"
        }
    }
}
