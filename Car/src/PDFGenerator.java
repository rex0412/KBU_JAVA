import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.UnitValue;
import com.itextpdf.kernel.colors.DeviceRgb;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.io.font.PdfEncodings;
import com.itextpdf.io.font.constants.StandardFonts;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class PDFGenerator {
    public void generatePDF(List<Vehicle> vehicles, String outputPath) throws Exception {
        // 기존 파일 삭제
        if (Files.exists(Paths.get(outputPath))) {
            Files.delete(Paths.get(outputPath));
        }

        PdfWriter writer = new PdfWriter(outputPath);
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf);

        // 한글 폰트 설정
        PdfFont font;
        try {
            font = PdfFontFactory.createFont(
                    "c:/windows/fonts/malgun.ttf",
                    PdfEncodings.IDENTITY_H,
                    true
            );
        } catch (Exception e) {
            font = PdfFontFactory.createFont(StandardFonts.HELVETICA);
        }

        // 제목: "차량 정보 리스트"
        Paragraph title = new Paragraph("차량 정보 리스트")
                .setFontColor(ColorConstants.BLUE)
                .setFontSize(18)
                .setBold()
                .setTextAlignment(TextAlignment.CENTER)
                .setFont(font);
        document.add(title);

        // 작성일: 오늘 날짜 (오른쪽 정렬)
        LocalDate today = LocalDate.now();
        String formattedDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        Paragraph dateInfo = new Paragraph("작성일: " + formattedDate)
                .setTextAlignment(TextAlignment.RIGHT)
                .setFontSize(10)
                .setFont(font);
        document.add(dateInfo);

        // 공백 추가
        document.add(new Paragraph(" "));

        // 12개 컬럼 (폰트 크기와 컬럼 너비 조정)
        String[] headers = {
                "소유주", "제조사", "모델", "년도", "차종", "연료", "배기량", "가격",
                "세금", "교육세", "환경세", "납부세액"
        };

        // 컬럼 너비를 더 세밀하게 조정 (가로 출력 최적화)
        float[] columnWidths = {1.5f, 1.5f, 1.5f, 1f, 1.2f, 1.2f, 1.2f, 2f, 2f, 1.8f, 1.8f, 2.5f};
        Table table = new Table(UnitValue.createPercentArray(columnWidths))
                .useAllAvailableWidth();

        // 헤더 셀 (폰트 크기 줄임)
        for (String h : headers) {
            Cell headerCell = new Cell()
                    .add(new Paragraph(h).setFont(font).setBold().setFontSize(8))
                    .setBackgroundColor(new DeviceRgb(221, 221, 221))
                    .setTextAlignment(TextAlignment.CENTER)
                    .setPadding(3);
            table.addHeaderCell(headerCell);
        }

        // 데이터 (폰트 크기 줄임)
        for (Vehicle v : vehicles) {
            double baseTax = v.calculateBaseTax();
            double eduTax = v.calculateEducationTax(baseTax);
            double envTax = v.calculateEnvironmentalTax(baseTax);

            // 각 셀의 폰트 크기를 7로 줄여서 가로로 출력되도록 함
            table.addCell(new Cell().add(new Paragraph(v.owner).setFont(font).setFontSize(7)).setPadding(2));
            table.addCell(new Cell().add(new Paragraph(v.manufacturer).setFont(font).setFontSize(7)).setPadding(2));
            table.addCell(new Cell().add(new Paragraph(v.model).setFont(font).setFontSize(7)).setPadding(2));
            table.addCell(new Cell().add(new Paragraph(String.valueOf(v.year)).setFont(font).setFontSize(7)).setPadding(2));
            table.addCell(new Cell().add(new Paragraph(v.carType).setFont(font).setFontSize(7)).setPadding(2));
            table.addCell(new Cell().add(new Paragraph(v.fuelType).setFont(font).setFontSize(7)).setPadding(2));
            table.addCell(new Cell().add(new Paragraph(String.valueOf(v.cc)).setFont(font).setFontSize(7)).setPadding(2));
            table.addCell(new Cell().add(new Paragraph(formatCurrency(v.price)).setFont(font).setFontSize(7)).setPadding(2));
            table.addCell(new Cell().add(new Paragraph(formatCurrency(baseTax)).setFont(font).setFontSize(7)).setPadding(2));
            table.addCell(new Cell().add(new Paragraph(formatCurrency(eduTax)).setFont(font).setFontSize(7)).setPadding(2));
            table.addCell(new Cell().add(new Paragraph(formatCurrency(envTax)).setFont(font).setFontSize(7)).setPadding(2));
            table.addCell(new Cell().add(new Paragraph(formatCurrency(v.calculateTotalTax())).setFont(font).setFontSize(7)).setPadding(2));
        }

        document.add(table);
        document.close();
    }

    private String formatCurrency(double amount) {
        return String.format("%,.0f원", amount);
    }
}
