import java.util.Map;

public class Main {
    public static void main(String[] args) {
        try {
            ExcelReader reader = new ExcelReader();
            Map<String, ClassRoom> classes = reader.readExcel("data/students.xlsx");

            Grade grade1 = new Grade("1학년");
            for (ClassRoom cr : classes.values()) {
                cr.calculateClassRank();
                grade1.addClassRoom(cr);
            }
            grade1.calculateGradeRank();

            PDFGenerator pdfGen = new PDFGenerator();
            for (String className : classes.keySet()) {
                ClassRoom classRoom = classes.get(className);

                // generateClassPDF() 호출 (매개변수: ClassRoom, 출력 경로)
                pdfGen.generateClassPDF(
                        classRoom,
                        "data/" + className + ".pdf"
                );
                System.out.println("PDF 생성 완료: " + className + ".pdf");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
