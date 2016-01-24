package com.chaparolo.service.model;

import java.util.List;

public class Model {

    private String name;
    private List<Product> products;

    public Model() {
    }

    public Model(String name, List<Product> products) {
	this.name = name;
	this.products = products;
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
