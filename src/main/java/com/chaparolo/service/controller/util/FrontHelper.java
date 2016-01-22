package com.chaparolo.service.controller.util;


import java.util.Map;

import spark.Request;

public class FrontHelper {

    private static final Long STATIC_CONTENT_VERSION = System.currentTimeMillis();

    private String appBasePath;

    public FrontHelper(String appBasePath) {
        this.appBasePath = appBasePath;
    }

    public void addCommonObjectsToModel(Request request, Map<String, Object> model) {
        model.put("basePath", this.appBasePath);
        model.put("jsPath", this.appBasePath + "/js");
        model.put("cssPath", this.appBasePath + "/css");
        model.put("imgPath", this.appBasePath + "/img");
        model.put("staticContentVersion", STATIC_CONTENT_VERSION);
    }

}
