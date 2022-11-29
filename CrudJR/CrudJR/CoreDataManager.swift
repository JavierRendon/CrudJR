//
//  CoreDataManager.swift
//  CrudJR
//
//  Created by CCDM07 on 28/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer: NSPersistentContainer

    init(){
        persistentContainer = NSPersistentContainer(name: "CrudJR")
        persistentContainer.loadPersistentStores(completionHandler:{
            (descripcion, error) in
            if let error = error {
                fatalError("Core data fallo \(error.localizedDescription)")
            }
        })
    }

    func guardarPedidos(idPedido: String, cliente: String, articulo: String, fechaEntrega: String, direccion: String, total: String, estado: String){
        let pedido = Pedido(context: persistentContainer.viewContext)
        pedido.idPedido = idPedido
        pedido.cliente = cliente
        pedido.articulo =  articulo
        pedido.fechaEntrega = fechaEntrega
        pedido.direccion = direccion
        pedido.total = total
        pedido.estado = estado
        
        do{
            try persistentContainer.viewContext.save()
            print("Guardado")
        }
        catch{
            print("Fallo al guardar")
        }
    }

    func leerTodosLosPedidos() -> [Pedido]{
        let fetchRequest: NSFetchRequest<Pedido> = Pedido.fetchRequest()

        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return []
        }
    }

    func borrarPedidos(pedido: Pedido){
        persistentContainer.viewContext.delete(pedido)

        do{
            try persistentContainer.viewContext.save()
        }catch{
            persistentContainer.viewContext.rollback()
            print("Fallo al guardar")
        }
    }

    func actualizarPedidos(pedido: Pedido){
        let fetchRequest: NSFetchRequest<Pedido> = Pedido.fetchRequest()
        let predicate = NSPredicate(format: "idPedido = %@", pedido.idPedido ?? "")
        fetchRequest.predicate = predicate


        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let p = datos.first
            p?.idPedido = pedido.idPedido
            try persistentContainer.viewContext.save()
            print("Pedido Actualizado")
        }catch{
            print("failed to save error en \(error)")
        }
    }

    func leerPedidos(idPedido: String) -> Pedido?{
        let fetchRequest: NSFetchRequest<Pedido> = Pedido.fetchRequest()
        let predicate = NSPredicate(format: "idPedido = %@", idPedido)
        fetchRequest.predicate = predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
        }catch{
            print("failed to save error en \(error)")
        }
        return nil
    }
}
