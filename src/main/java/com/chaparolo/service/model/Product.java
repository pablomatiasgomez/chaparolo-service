package com.chaparolo.service.model;

import com.despegar.integration.mongo.entities.IdentifiableEntity;

public class Product implements IdentifiableEntity {

    private String id;
    private String name;
    private String price;

    public Product(String name, String price) {
	this.name = name;
	this.price = price;
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

    public String getPrice() {
	return this.price;
    }

    public void setPrice(String price) {
	this.price = price;
    }

}
