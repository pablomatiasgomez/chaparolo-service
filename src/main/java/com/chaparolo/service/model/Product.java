package com.chaparolo.service.model;

import com.despegar.integration.mongo.entities.IdentifiableEntity;

public class Product implements IdentifiableEntity {

    private String id;
    private String brand;
    private String model;
    private String name;
    private String price;

    public Product() {
    }

    public Product(String brand, String model, String name, String price) {
	this.brand = brand;
	this.model = model;
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

    public String getBrand() {
	return this.brand;
    }

    public void setBrand(String brand) {
	this.brand = brand;
    }

    public String getModel() {
	return this.model;
    }

    public void setModel(String model) {
	this.model = model;
    }

    public String getPrice() {
	return this.price;
    }

    public void setPrice(String price) {
	this.price = price;
    }

}
