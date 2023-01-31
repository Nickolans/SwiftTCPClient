//
//  TCPClientHandler.swift
//  
//
//  Created by Nickolans Griffith on 1/30/23.
//

import Foundation
import NIO

class TCPClientHandler: ChannelInboundHandler, ChannelOutboundHandler {
    
    typealias InboundIn = ByteBuffer
    typealias OutboundOut = ByteBuffer
    typealias OutboundIn = ByteBuffer
    
    func channelActive(context: ChannelHandlerContext) {
        //
    }
    
    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let buffer = unwrapInboundIn(data)
        guard let bytes = buffer.getBytes(at: 0, length: buffer.readableBytes) else { return }
        let data = Data(bytes)
        
        NotificationCenter.default.post(name: Constants.readName, object: data)
    }
    
    func errorCaught(context: ChannelHandlerContext, error: Error) {
        //
    }
    
    func write(context: ChannelHandlerContext, data: NIOAny, promise: EventLoopPromise<Void>?) {
        //
    }
    
    func close(context: ChannelHandlerContext, mode: CloseMode, promise: EventLoopPromise<Void>?) {
        //
    }
}
