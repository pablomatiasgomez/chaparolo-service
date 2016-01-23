package com.chaparolo.service.model;

import java.util.List;

import com.despegar.integration.mongo.entities.IdentifiableEntity;

public class Model implements IdentifiableEntity {

    private String id;
    private String name;
    private List<Product> products;

    public Model(String name) {
	this.name = name;
    }

    @Override
    public String getId() {
	return this.id;
    }

    @Override
    public void setId(String id) {
	this.id = id;
    }

    public String getName() {
	return this.name;
    }

    public void setName(String name) {
	this.name = name;
    }

    public List<Product> getProducts() {
	return this.products;
    }

    public void setProducts(List<Product> products) {
	this.products = products;
    }

}
