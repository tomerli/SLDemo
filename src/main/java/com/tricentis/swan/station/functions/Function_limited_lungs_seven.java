package com.tricentis.swan.station.functions;

import org.springframework.stereotype.Component;

@Component
public class Function_limited_lungs_seven implements Function {

    /*
     This is a test Ian Flanagan
    */
    @Override
    public String execute() {
        System.out.println("function_limited_lungs_seven executed.");
        return "function_limited_lungs_seven executed";
    }
}
