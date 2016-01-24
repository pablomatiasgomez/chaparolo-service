package com.chaparolo.service.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import org.apache.log4j.Logger;

import com.chaparolo.service.model.Brand;
import com.chaparolo.service.util.ProductMapper;
import com.despegar.integration.mongo.connector.MongoCollection;
import com.despegar.integration.mongo.query.Query;

public class BrandsService {

    private static final Logger logger = Logger.getLogger(BrandsService.class);

    private MongoCollection<Brand> brands;

    public BrandsService(MongoCollection<Brand> brands) {
	this.brands = brands;
    }

    private String add(Brand brand) {
	return this.brands.add(brand);
    }

    private void clearCollection() {
	this.brands.remove(new Query());
    }

    public List<Brand> getAll() {
	return this.brands.find(new Query().limit(999999999));
    }

    public Object get(Query query) {
	query.limit(99999999);
	return this.brands.find(query);
    }

    public void saveProductsFromXLS(String file) throws FileNotFoundException, IOException {
	logger.info("Saving products from XLS");

	this.clearCollection();
	ProductMapper.getProductsFromXLS(file).forEach(this::add);
    }

}
