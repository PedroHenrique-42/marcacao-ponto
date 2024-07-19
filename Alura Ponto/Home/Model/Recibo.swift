//
//  Recibo.swift
//  Alura Ponto
//
//  Created by Ândriu Felipe Coelho on 29/09/21.
//

import CoreData
import Foundation
import UIKit

@objc(Recibo)
class Recibo: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var status: Bool
    @NSManaged var data: Date
    @NSManaged var foto: UIImage

    convenience init(status: Bool, data: Date, foto: UIImage) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.init(context: appDelegate.persistentContainer.viewContext)
        self.id = UUID()
        self.status = status
        self.data = data
        self.foto = foto
    }
}

extension Recibo {
    // MARK: - Core Data - DAO

    class func fetchRequest() -> NSFetchRequest<Recibo> {
        return NSFetchRequest(entityName: "Recibo")
    }

    func salvar(_ contexto: NSManagedObjectContext) {
        do {
            try contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    class func carregar(
        _ fetchedResultsController: NSFetchedResultsController<Recibo>
    ) {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }

    func deletar(_ contexto: NSManagedObjectContext) {
        contexto.delete(self)

        do {
            try contexto.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
