package com.tricentis.swan.station.service;

import org.springframework.stereotype.Service;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.util.StringUtils;
import org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider;
import org.springframework.core.type.filter.AnnotationTypeFilter;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.Set;

@Service
public class FunctionService {
    private final List<String> logs = new CopyOnWriteArrayList<>();
    private final PathMatchingResourcePatternResolver resourceResolver = new PathMatchingResourcePatternResolver();

    public List<String> listFunctions() {
        List<String> functions = new ArrayList<>();
        try {
            ClassPathScanningCandidateComponentProvider scanner = new ClassPathScanningCandidateComponentProvider(false);
            scanner.addIncludeFilter(new AnnotationTypeFilter(Component.class));
            Set<org.springframework.beans.factory.config.BeanDefinition> components = scanner.findCandidateComponents("com.tricentis.swan.station.functions");
            
            for (org.springframework.beans.factory.config.BeanDefinition bean : components) {
                String className = bean.getBeanClassName();
                if (className != null) {
                    String simpleName = className.substring(className.lastIndexOf('.') + 1);
                    functions.add(simpleName + ".java");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return functions;
    }

    public void executeFunction(String functionFile) {
        try {
            String className = StringUtils.stripFilenameExtension(functionFile);
            className = className.replace("-", " ");
            className = className.substring(0, 1).toUpperCase() + className.substring(1);
            className = className.replace(" ", "");
            
            Class<?> functionClass = Class.forName("com.tricentis.swan.station.functions." + className);
            Object instance = functionClass.getDeclaredConstructor().newInstance();
            String result = (String) functionClass.getMethod("execute").invoke(instance);
            logs.add(result);
        } catch (Exception e) {
            logs.add("Error executing function file " + functionFile + ": " + e.getMessage());
        }
    }

    public List<String> getLogs() {
        return new ArrayList<>(logs);
    }
} 