package com.tricentis.swan.station.functions;

import org.springframework.stereotype.Component;

@Component
public class Function_effort_land_garage implements Function {
    @Override
    public String execute() {
        System.out.println("function_effort_land_garage executed!");
        return "function_effort_land_garage executed";
    }
}
