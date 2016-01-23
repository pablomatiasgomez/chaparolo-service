package com.chaparolo.service.service;

import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.log4j.Logger;

import com.chaparolo.service.model.Product;
import com.chaparolo.service.util.ProductMapper;
import com.despegar.integration.mongo.connector.MongoCollection;
import com.despegar.integration.mongo.query.Query;

public class BrandsService {

    private static final Logger logger = Logger.getLogger(BrandsService.class);

    private MongoCollection<Product> products;

    public BrandsService(MongoCollection<Product> products) {
	this.products = products;
    }

    private String add(Product product) {
	return this.products.add(product);
    }

    private void clearCollection() {
	this.products.remove(new Query());
    }

    public void saveProductsFromXLS(String file) throws FileNotFoundException, IOException {
	logger.info("Saving products from XLS");

	this.clearCollection();
	ProductMapper.getProductsFromXLS(file).forEach(this::add);
    }

}
