import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.File;
import java.io.FileInputStream;
import java.util.*;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import com.google.zxing.*;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.HybridBinarizer;

public class Main {
    public static void main(String[] args) {
        try {
            Map<String, SubjectInfo> subjectInfoMap = loadSubjectInfo("data/subject.xlsx");
            List<Student> students = loadStudents("data/student.xlsx", subjectInfoMap);
            ClassRoom classRoom = new ClassRoom(students, subjectInfoMap);

            // 바코드 이미지 여러 개 처리 예시 (barcode.png ~ barcode9.png)
            for (int i = 0; i < 10; i++) {
                String barcodeFilePath = (i == 0) ? "data/barcode.png" : "data/barcode" + i + ".png";
                String studentId = extractStudentIdFromBarcode(barcodeFilePath);

                System.out.println("\n=== [" + barcodeFilePath + "] ===");
                if (studentId.isEmpty()) {
                    System.out.println("바코드에서 학번을 읽을 수 없습니다.");
                    continue;
                }

                Student student = classRoom.findStudentById(studentId);
                if (student != null) {
                    student.displayInfo(classRoom);
                } else {
                    System.out.println("학생을 찾을 수 없습니다. (학번: " + studentId + ")");
                }
            }
        } catch (Exception e) {
            System.err.println("오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static String extractStudentIdFromBarcode(String filePath) {
        try {
            BufferedImage image = ImageIO.read(new File(filePath));
            LuminanceSource source = new BufferedImageLuminanceSource(image);
            BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
            Result result = new MultiFormatReader().decode(bitmap);
            String decodedText = result.getText();
            return decodedText.trim();
        } catch (Exception e) {
            System.err.println("[경고] 바코드 디코딩 실패: " + e.getMessage());
            return new File(filePath).getName().replaceAll("[^0-9]", "");
        }
    }

    private static Map<String, SubjectInfo> loadSubjectInfo(String filePath) throws Exception {
        Map<String, SubjectInfo> map = new HashMap<>();
        try (FileInputStream fis = new FileInputStream(filePath);
             XSSFWorkbook workbook = new XSSFWorkbook(fis)) {
            Sheet sheet = workbook.getSheetAt(0);
            for (Row row : sheet) {
                if (row.getRowNum() == 0) continue;
                String code = getCellValue(row.getCell(0));
                String name = getCellValue(row.getCell(1));
                String type = getCellValue(row.getCell(2));
                int credit = 0;
                try {
                    String creditValue = getCellValue(row.getCell(3));
                    if (!creditValue.isEmpty()) {
                        credit = Integer.parseInt(creditValue);
                    }
                } catch (NumberFormatException e) {
                    System.err.printf("[경고] '%s' 과목 학점 오류: %s (기본값 0 적용)%n", name, e.getMessage());
                }
                map.put(code, new SubjectInfo(code, name, type, credit));
            }
        }
        return map;
    }

    private static List<Student> loadStudents(String filePath, Map<String, SubjectInfo> subjectInfoMap) throws Exception {
        List<Student> students = new ArrayList<>();
        try (FileInputStream fis = new FileInputStream(filePath);
             XSSFWorkbook workbook = new XSSFWorkbook(fis)) {
            Sheet sheet = workbook.getSheetAt(0);
            for (Row row : sheet) {
                if (row.getRowNum() == 0) continue;
                String id = getCellValue(row.getCell(0));
                String name = getCellValue(row.getCell(1));
                String department = getCellValue(row.getCell(2));
                String[] codes = getCellValue(row.getCell(3)).split(",");
                String[] scores = getCellValue(row.getCell(4)).split(",");
                List<Subject> subjects = new ArrayList<>();
                for (int i = 0; i < codes.length; i++) {
                    String code = codes[i].trim();
                    int score = 0;
                    try {
                        score = Integer.parseInt(scores[i].trim());
                    } catch (Exception e) {
                        System.err.printf("[경고] %s 학생의 %s 과목 점수 오류: %s (기본값 0 적용)%n", name, code, e.getMessage());
                    }
                    SubjectInfo info = subjectInfoMap.get(code);
                    if (info == null) continue;
                    if (info.getType().equals("M")) {
                        subjects.add(new MajorSubject(info.getName(), score, code));
                    } else {
                        subjects.add(new GeneralSubject(info.getName(), score, code));
                    }
                }
                students.add(new Student(name, id, department, subjects));
            }
        }
        return students;
    }

    private static String getCellValue(Cell cell) {
        if (cell == null) return "";
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                double numValue = cell.getNumericCellValue();
                return numValue == (int) numValue ? String.valueOf((int) numValue) : String.valueOf(numValue);
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            case BLANK:
                return "";
            default:
                return "";
        }
    }
}
