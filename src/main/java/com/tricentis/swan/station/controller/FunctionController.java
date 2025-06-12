package com.tricentis.swan.station.controller;

import com.tricentis.swan.station.service.FunctionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class FunctionController {

    private final FunctionService functionService;

    @Autowired
    public FunctionController(FunctionService functionService) {
        this.functionService = functionService;
    }

    @GetMapping("/")
    public String index(Model model) {
        List<String> functions = functionService.listFunctions();
        List<String> logs = functionService.getLogs();
        model.addAttribute("functions", functions);
        model.addAttribute("logs", logs);
        return "index";
    }

    @PostMapping("/execute")
    public String executeFunction(@RequestParam String functionFile) {
        functionService.executeFunction(functionFile);
        return "redirect:/";
    }
} 