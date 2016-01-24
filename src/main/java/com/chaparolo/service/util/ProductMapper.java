package com.chaparolo.service.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;

import com.chaparolo.service.model.Brand;
import com.chaparolo.service.model.Model;
import com.chaparolo.service.model.Product;

public class ProductMapper {

    private static final Logger logger = Logger.getLogger(ProductMapper.class);

    public static List<Brand> getProductsFromXLS(String file) throws FileNotFoundException, IOException {
	logger.info("Opening XLS to get products");

	HSSFWorkbook wb = new HSSFWorkbook(new POIFSFileSystem(new FileInputStream(file)));
	HSSFSheet sheet = wb.getSheetAt(0);
	int rows = sheet.getPhysicalNumberOfRows();

	Map<String, Map<String, List<Product>>> productsByBrands = new HashMap<>();

	IntStream.range(0, rows).boxed().map(sheet::getRow).filter(ProductMapper::isProduct).forEach(row -> {
	    String brandModel = getCellValue(row.getCell(0));
	    String brand = brandModel.split(" ")[0];
	    String model = brandModel.replace(brand, "").trim();
	    String name = getCellValue(row.getCell(1));
	    String price = getCellValue(row.getCell(2));

	    if (!productsByBrands.containsKey(brand)) {
		productsByBrands.put(brand, new HashMap<>());
	    }
	    Map<String, List<Product>> modelMap = productsByBrands.get(brand);
	    if (!modelMap.containsKey(model)) {
		modelMap.put(model, new ArrayList<>());
	    }
	    List<Product> products = modelMap.get(model);

	    products.add(new Product(name, price));
	});

	wb.close();

	List<Brand> brands = new ArrayList<>();
	productsByBrands.forEach((brandName, modelNames) -> {
	    List<Model> models = modelNames.entrySet().stream().map(entry -> {
		return new Model(entry.getKey(), entry.getValue());
	    }).collect(Collectors.toList());
	    brands.add(new Brand(brandName, models));
	});

	return brands;

    }

    private static boolean isProduct(HSSFRow row) {
	if (row == null) {
	    return false;
	}
	HSSFCell cell = row.getCell(2);
	return cell != null && cell.getCellType() == Cell.CELL_TYPE_NUMERIC;
    }

    private static String getCellValue(HSSFCell cell) {
	switch (cell.getCellType()) {
	case Cell.CELL_TYPE_STRING:
	    return cell.getRichStringCellValue().getString().trim();
	case Cell.CELL_TYPE_NUMERIC:
	    if (DateUtil.isCellDateFormatted(cell)) {
		return cell.getDateCellValue().toString().trim();
	    } else {
		return new Double(cell.getNumericCellValue()).toString().trim();
	    }
	case Cell.CELL_TYPE_BOOLEAN:
	    return new Boolean(cell.getBooleanCellValue()).toString().trim();
	case Cell.CELL_TYPE_FORMULA:
	    return cell.getCellFormula().trim();
	default:
	    return "";
	}
    }

}
