import java.io.FileOutputStream;
import java.util.List;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

public class PDFReport {
    public static void generateReport(List<ClassRoom> classrooms, String filename) throws Exception {
        Document document = new Document();
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(filename));
        document.open();

        // 한글 폰트 경로를 data/SDSwaggerTTF.ttf로 지정
        BaseFont bf = BaseFont.createFont(
                "data/SDSwaggerTTF.ttf",  // 폰트 경로
                BaseFont.IDENTITY_H,
                BaseFont.EMBEDDED
        );
        Font font = new Font(bf, 12);

        for (ClassRoom cr : classrooms) {
            document.add(new Paragraph(cr.getName() + " 성적표", font));
            document.add(Chunk.NEWLINE);

            PdfPTable table = new PdfPTable(10);
            table.setWidthPercentage(100);

            addTableHeader(table, font, "학번", "이름", "국어", "영어", "수학", "선택", "총점", "평균", "반등수", "학년석차");

            for (Student s : cr.getStudents()) {
                addRow(table, font,
                        s.getHakbun(),
                        s.getName(),
                        String.valueOf(s.getKor()),
                        String.valueOf(s.getEng()),
                        String.valueOf(s.getMath()),
                        String.valueOf(s.getOption()),
                        String.valueOf(s.getSum()),
                        String.format("%.2f", s.getAvg()),
                        String.valueOf(s.getRank()),
                        String.valueOf(s.getGradeRank())
                );
            }

            document.add(table);
            document.newPage();
        }
        document.close();
    }

    private static void addTableHeader(PdfPTable table, Font font, String... headers) {
        for (String header : headers) {
            PdfPCell cell = new PdfPCell(new Phrase(header, font));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setBackgroundColor(new BaseColor(240, 240, 240));
            table.addCell(cell);
        }
    }

    private static void addRow(PdfPTable table, Font font, String... data) {
        for (String item : data) {
            PdfPCell cell = new PdfPCell(new Phrase(item, font));
            cell.setPadding(5);
            table.addCell(cell);
        }
    }
}
