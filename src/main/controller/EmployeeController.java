package com.example.employee.controller;

import com.example.employee.model.Employee;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/employees")
public class EmployeeController {

    private Map<Integer, Employee> employeeMap = new HashMap<>();

    @PostMapping
    public Employee addEmployee(@RequestBody Employee employee) {
        employeeMap.put(employee.getId(), employee);
        return employee;
    }

    @GetMapping
    public Collection<Employee> getAllEmployees() {
        return employeeMap.values();
    }

    @GetMapping("/{id}")
    public Employee getEmployee(@PathVariable int id) {
        return employeeMap.get(id);
    }
}
