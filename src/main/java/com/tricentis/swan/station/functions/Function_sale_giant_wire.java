package com.tricentis.swan.station.functions;

import org.springframework.stereotype.Component;

@Component
public class Function_sale_giant_wire implements Function {
    @Override
    public String execute() {
        System.out.println("function_sale_giant_wire executed");
        return "function_sale_giant_wire executed";
    }
}
