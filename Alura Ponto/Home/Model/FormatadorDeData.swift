//
//  FormatadorDeData.swift
//  Alura Ponto
//
//  Created by Ândriu Felipe Coelho on 27/09/21.
//

import Foundation

enum TipoData {
    case horario, dataEHorario
}

struct FormatadorDeData {
        
    func getData(_ data: Date) -> String {
        let formatador = DateFormatter()
        formatador.timeZone = TimeZone(abbreviation: "GMT-3")
        formatador.dateFormat = "dd/MM/yyyy HH:mm"
        
        return formatador.string(from: data)
    }
    
    func getHorario(_ data: Date) -> String {
        let formatador = DateFormatter()
        formatador.timeZone = TimeZone(abbreviation: "GMT-3")
        formatador.dateFormat = "HH:mm"
        
        return formatador.string(from: data)
    }
}
