import Foundation

protocol ProfileProtocol {
    var id: String { get }
    var firstName: String { get }
    var lastName: String { get }
    var photoURL: URL? { get }

    init(id: String, firstName: String, lastName: String, photoURL: URL?)

    func fullName() -> String
}

protocol RecordProtocol {
    var id: String { get }
    var date: Date { get }
    var description: String { get }

    init(id: String, date: Date, description: String)
}
