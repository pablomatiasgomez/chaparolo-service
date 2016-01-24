package com.chaparolo.service.query;

import com.chaparolo.service.controller.util.ParamsHelper;
import com.despegar.integration.mongo.query.Query;

import spark.Request;
import spark.utils.StringUtils;

public class QueryBuilder {

    public static Query build(Request request) {
	Query query = new Query();

	String brand = ParamsHelper.getStringQueryParam(request, "brand");
	if (StringUtils.isNotEmpty(brand)) {
	    query.equals("name", brand);
	}

	return query;
    }
}