import Foundation

struct Profile: ProfileProtocol {
    var id: String
    var firstName: String
    var lastName: String
    var photoURL: URL?

    init(id: String, firstName: String, lastName: String, photoURL: URL?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.photoURL = photoURL
    }

    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
}

struct Record: RecordProtocol {
    var id: String
    var date: Date
    var description: String

    init(id: String, date: Date, description: String) {
        self.id = id
        self.date = date
        self.description = description
    }
}
