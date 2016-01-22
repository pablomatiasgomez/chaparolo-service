package com.chaparolo.service.service;

import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.log4j.Logger;

import com.chaparolo.service.model.Product;
import com.chaparolo.service.util.ProductsUtils;
import com.despegar.integration.mongo.connector.MongoCollection;
import com.despegar.integration.mongo.query.Query;

public class ProductsService {

    private static final Logger logger = Logger.getLogger(ProductsService.class);

    private MongoCollection<Product> products;

    public ProductsService(MongoCollection<Product> products) {
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
	ProductsUtils.getProductsFromXLS(file).forEach(this::add);
    }

}
