package com.tricentis.swan.station.functions;

import org.springframework.stereotype.Component;

@Component
public class Function_crack_least_larger implements Function {
    @Override
    // adding a commment now
    public String execute() {
        System.out.println("function_crack_least_larger executed!");
        return "function_crack_least_larger executed";
    }
}
