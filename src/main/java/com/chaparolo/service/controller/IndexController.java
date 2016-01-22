package com.chaparolo.service.controller;

import java.util.HashMap;
import java.util.Map;

import com.chaparolo.service.controller.util.FrontHelper;

import spark.ModelAndView;
import spark.Spark;

public class IndexController {

    private String appBasePath;
    private FrontHelper frontHelper;

    public IndexController(FrontHelper frontHelper, String appBasePath) {
	this.frontHelper = frontHelper;
	this.appBasePath = appBasePath;
    }

    public void register() {
	Spark.get(this.appBasePath, (request, response) -> {

	    Map<String, Object> attributes = new HashMap<>();
	    this.frontHelper.addCommonObjectsToModel(request, attributes);

	    return new ModelAndView(attributes, "index.ftl");
	});
    }

}
