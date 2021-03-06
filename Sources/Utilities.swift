//
//  Utilities.swift
//  Connection
//
//  Created by Wesley Cope on 2/2/16.
//  Copyright © 2016 Pilot Foundation. All rights reserved.
//

import Foundation


#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

public struct SocketFunctions {
    #if os(Linux)
    public static let Create   = socket
    public static let Accept   = accept
    public static let Bind     = bind
    public static let Close    = close
    public static let Listen   = listen
    public static let Read     = read
    public static let Send     = send
    public static let Write    = write
    public static let Shutdown = shutdown
    public static let Select   = select
    public static let Pipe     = pipe
    public static let Option   = setsockopt

    #else
    public static let Create   = Darwin.socket
    public static let Accept   = Darwin.accept
    public static let Bind     = Darwin.bind
    public static let Close    = Darwin.close
    public static let Listen   = Darwin.listen
    public static let Read     = Darwin.read
    public static let Send     = Darwin.send
    public static let Write    = Darwin.write
    public static let Shutdown = Darwin.shutdown
    public static let Select   = Darwin.select
    public static let Pipe     = Darwin.pipe
    public static let Option   = Darwin.setsockopt
    #endif 

    public static let STREAM   = SOCK_STREAM
    public static let BACKLOG  = SOMAXCONN
    public static let NOSIGNAL = 0
    
    public static func htons(value:CUnsignedShort) -> CUnsignedShort {
        return (value << 8) + (value >> 8)
    }
    
    public static func AddressCast(pointer:UnsafeMutablePointer<Void>) -> UnsafeMutablePointer<sockaddr> {
        return UnsafeMutablePointer<sockaddr>(pointer)
    }
}

public struct SocketError : ErrorType, CustomStringConvertible {
    public let function:String
    public let error:Int32
    
    public init(function:String = #function) {
        self.function   = function
        self.error      = errno
    }
    
    public var description: String {
        return "[Error: \(error)] - Connection.\(function) failed."
    }
}

public typealias SocketDescriptor  = Int32
public typealias SocketPort        = UInt16
