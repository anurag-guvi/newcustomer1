package com.example.newcustomer1.mapper;

import com.example.newcustomer1.dto.CustomerDto;
import com.example.newcustomer1.entity.Customer;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface CustomerMapper {
    Customer toEntity(CustomerDto customerDto);
    CustomerDto toDto(Customer customer);
}