package com.chaparolo.service.controller;

import com.chaparolo.service.controller.util.JsonConverter;
import com.chaparolo.service.query.QueryBuilder;
import com.chaparolo.service.service.BrandsService;

import spark.Spark;

public class ServiceController {

    private String apiBasePath;
    private BrandsService brandsService;
    private JsonConverter jsonConverter;

    public ServiceController(String apiBasePath, BrandsService brandsService, JsonConverter jsonConverter) {
	this.apiBasePath = apiBasePath;
	this.brandsService = brandsService;
	this.jsonConverter = jsonConverter;
    }

    public void register() {
	Spark.get(this.apiBasePath + "/products", (request, response) -> {

	    response.type("application/json;charset=UTF-8");
	    return this.brandsService.get(QueryBuilder.build(request));
	} , this.jsonConverter);
    }

}
