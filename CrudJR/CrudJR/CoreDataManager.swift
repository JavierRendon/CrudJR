//
//  CoreDataManager.swift
//  CrudJR
//
//  Created by CCDM07 on 28/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "Pedido")
        persistentContainer.loadPersistentStores(completionHandler:{
            (description, error) in
            if let error = error{
                fatalError("Core data failed\(error.localizedDescription)")
            }
            
        })
    }
    func guardarPedido(idPedido :String, cliente:String, articulo:String, fechaEntrega:String, direccion:String, total:String, estado:String ){
        let pedido = Pedido(context: persistentContainer.viewContext)
    pedido.idPedido = idPedido
    pedido.cliente = cliente
    pedido.articulo = articulo
    pedido.fechaEntrega = fechaEntrega
    pedido.direccion = direccion
    pedido.total = total
    pedido.estado = estado
        
        do{
            try persistentContainer.viewContext.save()
            print("Pedido guardado")
        }
        catch{
            print ("Fallo al guardar el pedido")
        }
    }
    
    func leerPedidos() -> [Pedido] {
        let fetchRequest : NSFetchRequest<Pedido> = Pedido.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return[]
        }
    }
    
    func leerPedido(idPedido:String) -> Pedido?{
        let fetchRequest : NSFetchRequest<Pedido> = Pedido.fetchRequest()
        let predicate = NSPredicate(format: "idPedido = %@", idPedido)
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
            }
        catch{
            print("¡Error! No se puede leer ese dato")
        }
        return nil
    }
    
    func actualizarPedido(pedido: Pedido){
        let fetchRequest : NSFetchRequest<Pedido> = Pedido.fetchRequest()
        let predicate = NSPredicate(format: "idPedido = %@", pedido.idPedido ?? "")
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let p = datos.first
            p?.idPedido = pedido.idPedido
            p?.cliente = pedido.cliente
            p?.articulo = pedido.articulo
        p?.fechaEntrega = pedido.fechaEntrega
            p?.direccion = pedido.direccion
            p?.total = pedido.total
        p?.estado = pedido.estado
            try persistentContainer.viewContext.save()
            print("Pedido Actualizado")
        }catch{
            print("¡Error! Fallo al actualizar el pedido")
        }
    }
    
    func borraPedido(pedido:Pedido){
        persistentContainer.viewContext.delete(pedido)
    }
}
