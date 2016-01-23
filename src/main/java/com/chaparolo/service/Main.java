package com.chaparolo.service;

import com.chaparolo.service.controller.IndexController;
import com.chaparolo.service.controller.LoggedFilter;
import com.chaparolo.service.controller.util.FrontHelper;
import com.chaparolo.service.model.Product;
import com.chaparolo.service.service.BrandsService;
import com.despegar.integration.mongo.connector.MongoCollection;
import com.despegar.integration.mongo.connector.MongoCollectionFactory;
import com.despegar.integration.mongo.connector.MongoDBConnection;
import com.typesafe.config.Config;
import com.typesafe.config.ConfigFactory;

import spark.Spark;

public class Main {

    private static final String DB_NAME = "chaparolo";

    public static void main(String[] args) throws Exception {
	Config config = ConfigFactory.load("conf/env/application.conf");

	String appBasePath = config.getString("base-path");

	// Mongo
	Config mongoCfg = config.getConfig("mongo");
	String replicaSet = mongoCfg.getString("replica-set");
	MongoDBConnection dbConnection = new MongoDBConnection(DB_NAME, replicaSet);
	MongoCollectionFactory factory = new MongoCollectionFactory(dbConnection);
	MongoCollection<Product> products = factory.buildMongoCollection("products", Product.class);

	// Service
	BrandsService productsService = new BrandsService(products);

	Spark.port(config.getInt("web-server-port"));
	Spark.staticFileLocation("/public");

	productsService.saveProductsFromXLS("/home/pablo/Downloads/chaparolo.xls");
	// Controllers
	FrontHelper frontHelper = new FrontHelper(appBasePath);

	new LoggedFilter(appBasePath).register();
	new IndexController(frontHelper, appBasePath).register();
    }
}
