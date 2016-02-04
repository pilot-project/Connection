//
//  main.swift
//  Connection
//
//  Created by Wesley Cope on 2/3/16.
//  Copyright © 2016 Pilot Foundation. All rights reserved.
//

import Foundation

print("Starting Server")

do {
    let server = try Server(port:8080)

    print("Server started on port 8080...")
    try server.serve { (str, connection) in
        let message         = "Hello World"
        let contentLength   = message.utf8.count
        
        connection.write("HTTP/1.1 200 OK\n")
        connection.write("Server: Pilot 0.0.0\n")
        connection.write("Content-length: \(contentLength)\n")
        connection.write("Content-type: text-plain\n")
        connection.write("\r\n")
        
        connection.write(message)
        connection.close()
    }
    
}
catch {
    print("Fail boat")
}