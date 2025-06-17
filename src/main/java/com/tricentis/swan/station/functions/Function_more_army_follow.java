
package com.tricentis.swan.station.functions;

import org.springframework.stereotype.Component;

@Component
public class Function_more_army_follow implements Function {
    @Override
    public String execute() {
        System.out.println("function_more_army_follow executed.");;
        return "function_more_army_follow executed";
    }
}
