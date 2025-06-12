package com.tricentis.swan.station.functions;

import org.springframework.stereotype.Component;

@Component
public class Function_leader_pure_poem implements Function {
    @Override
    public String execute() {
        System.out.println("function_leader_pure_poem executed");
        return "function_leader_pure_poem executed";
    }
}