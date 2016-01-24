package com.chaparolo.service.controller;

import java.util.stream.Collectors;

import com.chaparolo.service.controller.util.JsonConverter;
import com.chaparolo.service.model.Product;
import com.chaparolo.service.service.ProductsService;

import spark.Spark;

public class ServiceController {

    private String apiBasePath;
    private ProductsService productsService;
    private JsonConverter jsonConverter;

    public ServiceController(String apiBasePath, ProductsService productsService, JsonConverter jsonConverter) {
	this.apiBasePath = apiBasePath;
	this.productsService = productsService;
	this.jsonConverter = jsonConverter;
    }

    public void register() {
	Spark.get(this.apiBasePath + "/products", (request, response) -> {

	    response.type("application/json;charset=UTF-8");
	    return this.productsService.getAll().stream().collect(Collectors.groupingBy(Product::getModel));
	} , this.jsonConverter);
    }

}
