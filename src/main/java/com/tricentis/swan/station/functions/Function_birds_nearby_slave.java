package com.tricentis.swan.station.functions;

import org.springframework.stereotype.Component;

@Component
public class Function_birds_nearby_slave implements Function {
    @Override
    public String execute() {
         System.out.println("Ian Test");
        System.out.println("function_birds_nearby_slave executed.");
        return "function_birds_nearby_slave executed";
    }
}
