package com.chaparolo.service.model;

import com.despegar.integration.mongo.entities.IdentifiableEntity;

public class Product implements IdentifiableEntity {

	private String id;
	private String brand;
	private String model;
	private String name;
	private String price;

	public Product(String brand, String model, String name, String price) {
		this.brand = brand;
		this.model = model;
		this.name = name;
		this.price = price;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

}
