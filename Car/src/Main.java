import java.util.*;

public class Main {
    public static void main(String[] args) {
        try {
            ExcelReader reader = new ExcelReader();
            List<Vehicle> vehicles = reader.readExcel("data/car.xlsx");

            System.out.println("읽은 차량 수: " + vehicles.size());
            for (Vehicle v : vehicles) {
                System.out.println(v.getOwner() + " - " + v.calculateTotalTax());
            }

            PDFGenerator generator = new PDFGenerator();
            generator.generatePDF(vehicles, "data/result.pdf");

            System.out.println("PDF 생성 완료!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
