//
//  ContentView.swift
//  CrudJR
//
//  Created by CCDM09 on 23/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let coreDM: CoreDataManager
    @State var idPedido = ""
    @State var cliente = ""
    @State var articulo = ""
    @State var fechaEntrega = ""
    @State var direccion = ""
    @State var total = ""
    @State var estado = ""
    @State var seleccionado:Pedido?
    @State var pedidoArray = [Pedido]()
    
    var body: some View{
        VStack{
            TextField("Id del Pedido", text: $idPedido)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Cliente del Pedido", text: $cliente)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Articulo del Pedido", text: $articulo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Fecha de Entrega del Pedido", text: $fechaEntrega)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Direccion del Pedido", text: $direccion)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        TextField("Total del Pedido", text: $total)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        TextField("Estado del Pedido", text: $estado)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("SAVE"){
                
                if (seleccionado != nil){
                    seleccionado?.idPedido = idPedido
                    seleccionado?.cliente = cliente
                    seleccionado?.articulo = articulo
                    seleccionado?.fechaEntrega = fechaEntrega
                    seleccionado?.direccion = direccion
            seleccionado?.total = total
            seleccionado?.estado = estado
                    coreDM.actualizarPedido(pedido: seleccionado!)
                }else{
                    coreDM.guardarPedido(idPedido: idPedido, cliente: cliente, articulo: articulo, fechaEntrega: fechaEntrega, direccion: direccion, total: total, estado: estado)
                }
                mostrarPedidos()
                idPedido = ""
                cliente = ""
                articulo = ""
                fechaEntrega = ""
                direccion = ""
        total = ""
        estado = ""
                seleccionado = nil
            }
            List{
                ForEach(pedidoArray, id: \.self){
                ped in
                VStack{
                    Text(ped.idPedido ?? "")
                    Text(ped.cliente ?? "")
                    Text(ped.articulo ?? "")
                    Text(ped.fechaEntrega ?? "")
                    Text(ped.direccion ?? "")
            Text(ped.total ?? "")
            Text(ped.estado ?? "")
                }
                .onTapGesture {
                    seleccionado = ped
                    idPedido = ped.idPedido ?? ""
            cliente = ped.cliente ?? ""
            articulo = ped.articulo ?? ""
            fechaEntrega = ped.fechaEntrega ?? ""
                    direccion = ped.direccion ?? ""
                    total = ped.total ?? ""
                    estado = ped.estado ?? ""
                }
            }
            .onDelete(perform: {
                indexSet in
                indexSet.forEach({index in
                    let pedido = pedidoArray[index]
                    coreDM.borraPedido(pedido: pedido)
                    mostrarPedidos()
                })
            })
        }
        Spacer()
    }.padding()
        .onAppear(perform: {
            mostrarPedidos()
        })
        
    }

    func mostrarPedidos(){
        pedidoArray = coreDM.leerPedidos()
    }
}


struct ContentView_preViews: PreviewProvider{
    static var previews: some View{
        ContentView(coreDM: CoreDataManager())
    }
}
