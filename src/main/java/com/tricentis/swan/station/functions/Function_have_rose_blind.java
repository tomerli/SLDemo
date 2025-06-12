package com.tricentis.swan.station.functions;

import org.springframework.stereotype.Component;

@Component
public class Function_have_rose_blind implements Function {
    @Override
    public String execute() {
        System.out.println("function_have_rose_blind executed");
        return "function_have_rose_blind executed";
    }
}