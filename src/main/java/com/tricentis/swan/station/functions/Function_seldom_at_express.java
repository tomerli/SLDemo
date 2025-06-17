
package com.tricentis.swan.station.functions;

import org.springframework.stereotype.Component;

@Component
public class Function_seldom_at_express implements Function {
    @Override
    public String execute() {
        System.out.println("function_seldom_at_express executed.");
        return "function_seldom_at_express executed";
    }
}
