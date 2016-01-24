package com.chaparolo.service.model;

public class Product {

    private String name;
    private String price;

    public Product() {
    }

    public Product(String name, String price) {
	this.name = name;
	this.price = price;
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
