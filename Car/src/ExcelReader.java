import org.apache.poi.ss.usermodel.*;
import java.io.FileInputStream;
import java.io.File;
import java.util.*;

public class ExcelReader {
    public List<Vehicle> readExcel(String filePath) throws Exception {
        List<Vehicle> vehicles = new ArrayList<>();
        try (FileInputStream fis = new FileInputStream(new File(filePath));
             Workbook workbook = WorkbookFactory.create(fis)) {

            DataFormatter formatter = new DataFormatter();
            Sheet sheet = workbook.getSheetAt(0);

            for (Row row : sheet) {
                if (row.getRowNum() == 0) continue; // 헤더 건너뛰기

                String typeCode = formatter.formatCellValue(row.getCell(0)).trim(); // 구분
                String owner = formatter.formatCellValue(row.getCell(1)).trim();    // 소유주
                String model = formatter.formatCellValue(row.getCell(2)).trim();    // 모델
                String manufacturer = formatter.formatCellValue(row.getCell(3)).trim(); // 제조사
                String yearStr = formatter.formatCellValue(row.getCell(4)).trim();  // 년도
                String priceStr = formatter.formatCellValue(row.getCell(5)).trim(); // 가격
                String carTypeCode = formatter.formatCellValue(row.getCell(6)).trim(); // 배기량/차종
                String fuelCode = formatter.formatCellValue(row.getCell(7)).trim(); // 연료
                String ccStr = formatter.formatCellValue(row.getCell(8)).trim();    // 배기량

                int year = parseIntSafe(yearStr);
                double price = parseDoubleSafe(priceStr);
                int cc = parseIntSafe(ccStr);

                if ("1".equals(typeCode)) { // 자동차
                    String carType = "승용차";
                    if ("2".equals(carTypeCode)) carType = "승합차";
                    String fuelType = "Gasoline";
                    if ("2".equals(fuelCode)) fuelType = "Diesel";
                    else if ("3".equals(fuelCode)) fuelType = "Electricity";
                    vehicles.add(new Car(owner, manufacturer, model, year, carType, fuelType, cc, price));
                } else if ("2".equals(typeCode)) { // 오토바이
                    vehicles.add(new Motorcycle(owner, manufacturer, model, year, cc, price));
                }
            }
        }
        return vehicles;
    }

    private int parseIntSafe(String value) {
        try {
            return Integer.parseInt(value.replace(".0", ""));
        } catch (Exception e) {
            return 0;
        }
    }

    private double parseDoubleSafe(String value) {
        try {
            return Double.parseDouble(value);
        } catch (Exception e) {
            return 0.0;
        }
    }
}
