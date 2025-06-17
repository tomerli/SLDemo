package com.tricentis.swan.station.functions;

import org.springframework.stereotype.Component;

@Component
public class Function_environment_saved_loud implements Function {
    @Override
    public String execute() {
        System.out.println("function_environment_saved_loud executed.");
        return "function_environment_saved_loud executed";
    }
}
