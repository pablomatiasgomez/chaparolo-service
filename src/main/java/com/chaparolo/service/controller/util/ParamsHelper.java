package com.chaparolo.service.controller.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import spark.Request;

public class ParamsHelper {

    public static String getUrlParam(Request request, String param) {
        return urlDecode(request.params(param));
    }

    public static String getStringQueryParam(Request request, String queryParam) {
        return urlDecode(request.queryParams(queryParam));
    }

    public static Boolean getBooleanQueryParam(Request request, String queryParam) {
        return getBooleanQueryParam(request, queryParam, null);
    }

    public static Boolean getBooleanQueryParam(Request request, String queryParam, Boolean defaults) {
        String value = getStringQueryParam(request, queryParam);
        return value != null ? Boolean.valueOf(value) : defaults;
    }

    public static Integer getIntegerQueryParam(Request request, String queryParam) {
        return getIntegerQueryParam(request, queryParam, null);
    }

    public static Integer getIntegerQueryParam(Request request, String queryParam, Integer defaults) {
        String value = getStringQueryParam(request, queryParam);
        return value != null ? Integer.valueOf(value) : defaults;
    }



    private static String urlDecode(String value) {
        try {
            if (value != null) {
                return URLDecoder.decode(value, "UTF-8");
            }
            return null;
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

}
