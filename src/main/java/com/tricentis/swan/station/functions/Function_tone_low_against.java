package com.tricentis.swan.station.functions;

import org.springframework.stereotype.Component;

@Component
public class Function_tone_low_against implements Function {
    @Override
    public String execute() {
        System.out.println("function_tone_low_against executed!");
        return "function_tone_low_against executed";
    }
}
