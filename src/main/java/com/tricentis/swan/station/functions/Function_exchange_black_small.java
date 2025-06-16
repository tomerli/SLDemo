package com.tricentis.swan.station.functions;

import org.springframework.stereotype.Component;

@Component
public class Function_exchange_black_small implements Function {
    @Override
    public String execute() {
        System.out.println("function_exchange_black_small executed");
        return "function_exchange_black_small executed";
    }
}
