package com.tricentis.swan.station.functions;

import org.springframework.stereotype.Component;

@Component
public class Function_doubt_boy_date implements Function {
    @Override
    public String execute() {
        System.out.println("function_doubt_boy_date executed!");
        return "function_doubt_boy_date executed";
    }
}
