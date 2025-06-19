import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import java.io.FileOutputStream;

public class PDFGenerator {
    private static final BaseColor LIGHT_YELLOW = new BaseColor(255, 255, 200);
    private static final BaseColor BLUE = new BaseColor(0, 0, 255);

    public void generateClassPDF(ClassRoom classRoom, String outputPath) throws Exception {
        Document document = new Document(PageSize.A4.rotate());
        PdfWriter.getInstance(document, new FileOutputStream(outputPath));
        document.open();

        BaseFont baseFont = BaseFont.createFont("data/SDSwaggerTTF.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

        // 폰트 스타일별 정의 (Bold 대신 크기/색상)
        Font titleFont = new Font(baseFont, 22, Font.NORMAL, BaseColor.RED);   // 제목: 크고 빨간색
        Font avgFont = new Font(baseFont, 14, Font.NORMAL, BLUE);              // 반 평균: 크고 파란색
        Font headerFont = new Font(baseFont, 13, Font.NORMAL, BaseColor.BLACK);// 표 헤더: 약간 크게
        Font nameFont = new Font(baseFont, 13, Font.NORMAL, BaseColor.BLACK);  // 이름/성별: 약간 크게
        Font blueFont = new Font(baseFont, 13, Font.NORMAL, BLUE);             // 석차: 파란색
        Font normalFont = new Font(baseFont, 12, Font.NORMAL, BaseColor.BLACK);// 일반

        // 제목
        Paragraph title = new Paragraph(classRoom.getClassName() + " 성적표", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);

        // 반 평균
        Paragraph avgPara = new Paragraph("반 평균 : " + String.format("%.2f", classRoom.getClassAverage()), avgFont);
        avgPara.setAlignment(Element.ALIGN_RIGHT);
        document.add(avgPara);
        document.add(Chunk.NEWLINE);

        // 표 생성
        PdfPTable table = new PdfPTable(11);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{1.5f, 1.5f, 1, 1.5f, 1.5f, 1.5f, 1.5f, 1.5f, 1.5f, 1.5f, 1.5f});

        // 헤더
        String[] headers = {"학번", "이름", "성별", "국어", "영어", "수학", "선택", "총점", "평균", "반 석차", "학년 석차"};
        for (String header : headers) {
            PdfPCell cell = new PdfPCell(new Phrase(header, headerFont));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPadding(5);
            table.addCell(cell);
        }

        // 데이터
        for (Student s : classRoom.getStudents()) {
            // 학번
            table.addCell(createCell(s.getHakbun(), normalFont));
            // 이름 (크기 강조)
            table.addCell(createCell(s.getName(), nameFont));
            // 성별 (크기 강조)
            table.addCell(createCell(String.valueOf(s.getGender()), nameFont));
            // 국어
            table.addCell(createCell(s.getKor() + "(" + s.getKorGrade() + ")", normalFont));
            // 영어
            table.addCell(createCell(s.getEng() + "(" + s.getEngGrade() + ")", normalFont));
            // 수학
            table.addCell(createCell(s.getMath() + "(" + s.getMathGrade() + ")", normalFont));
            // 선택
            table.addCell(createCell(s.getOption() + "(" + s.getOptionGrade() + ")", normalFont));
            // 총점
            table.addCell(createCell(String.valueOf(s.getSum()), normalFont));
            // 평균
            table.addCell(createCell(String.format("%.2f", s.getAvg()), normalFont));
            // 반 석차 (파란색, 노란 배경, 크기 강조)
            table.addCell(createColoredCell(String.valueOf(s.getClassRank()), blueFont, LIGHT_YELLOW));
            // 학년 석차 (파란색, 노란 배경, 크기 강조)
            table.addCell(createColoredCell(String.valueOf(s.getGradeRank()), blueFont, LIGHT_YELLOW));
        }

        document.add(table);
        document.close();
    }

    private PdfPCell createCell(String value, Font font) {
        PdfPCell cell = new PdfPCell(new Phrase(value, font));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setPadding(5);
        return cell;
    }

    private PdfPCell createColoredCell(String value, Font font, BaseColor bg) {
        PdfPCell cell = createCell(value, font);
        cell.setBackgroundColor(bg);
        return cell;
    }
}
