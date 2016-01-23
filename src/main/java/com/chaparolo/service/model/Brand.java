package com.chaparolo.service.model;

import java.util.List;

import com.despegar.integration.mongo.entities.IdentifiableEntity;

public class Brand implements IdentifiableEntity {

    private String id;
    private String name;
    private List<Model> models;

    public Brand(String name) {
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

    public List<Model> getModels() {
	return this.models;
    }

    public void setModels(List<Model> models) {
	this.models = models;
    }

}
