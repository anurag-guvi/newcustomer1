package com.example.newcustomer1.service;

import com.example.newcustomer1.dto.CustomerDto;

import java.util.List;

public interface CustomerService {
    CustomerDto createCustomer(CustomerDto customerDto);
    CustomerDto updateCustomer(Long id, CustomerDto customerDto);
    List<CustomerDto> getAllCustomers();
    CustomerDto getCustomerById(Long id);
    void deleteCustomer(Long id);
}