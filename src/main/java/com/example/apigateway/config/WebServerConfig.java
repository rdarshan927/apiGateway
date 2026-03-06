package com.example.apigateway.config;

import org.springframework.boot.web.embedded.netty.NettyReactiveWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.stereotype.Component;

@Component
public class WebServerConfig implements WebServerFactoryCustomizer<NettyReactiveWebServerFactory> {

    @Override
    public void customize(NettyReactiveWebServerFactory factory) {
        // Ensure server binds to all interfaces
        factory.setAddress("0.0.0.0");
        
        // Set port from environment variable or default to 8080
        String port = System.getenv("PORT");
        if (port != null && !port.isEmpty()) {
            factory.setPort(Integer.parseInt(port));
        }
    }
}