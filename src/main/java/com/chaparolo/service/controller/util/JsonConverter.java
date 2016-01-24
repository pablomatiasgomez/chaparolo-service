package com.chaparolo.service.controller.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import spark.ResponseTransformer;

public class JsonConverter implements ResponseTransformer {

    private ObjectMapper mapper;

    public JsonConverter(ObjectMapper mapper) {
	this.mapper = mapper;
    }

    @Override
    public String render(Object model) {
	try {
	    return this.mapper.writeValueAsString(model);
	} catch (JsonProcessingException e) {
	    throw new RuntimeException(e);
	}
    }
}