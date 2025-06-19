import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.*;
import java.util.*;

public class ExcelReader {
    public Map<String, ClassRoom> readExcel(String filePath) throws IOException {
        Map<String, ClassRoom> classes = new HashMap<>();

        try (FileInputStream fis = new FileInputStream(filePath);
             XSSFWorkbook workbook = new XSSFWorkbook(fis)) {

            for (int i = 0; i < workbook.getNumberOfSheets(); i++) {
                Sheet sheet = workbook.getSheetAt(i);
                String className = sheet.getSheetName();

                ClassRoom classRoom = new ClassRoom(className);

                for (Row row : sheet) {
                    if (row.getRowNum() == 0) continue; // 헤더 skip

                    String hakbun = getCellValue(row.getCell(0));
                    String name = getCellValue(row.getCell(1));
                    char gender = getCellValue(row.getCell(2)).charAt(0);
                    int kor = Integer.parseInt(getCellValue(row.getCell(3)));
                    int eng = Integer.parseInt(getCellValue(row.getCell(4)));
                    int math = Integer.parseInt(getCellValue(row.getCell(5)));
                    int option = Integer.parseInt(getCellValue(row.getCell(6)));

                    classRoom.addStudent(new Student(hakbun, name, gender, kor, eng, math, option));
                }
                classes.put(className, classRoom);
            }
        }
        return classes;
    }

    private String getCellValue(Cell cell) {
        DataFormatter formatter = new DataFormatter();
        return formatter.formatCellValue(cell).trim();
    }
}
