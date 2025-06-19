import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

public class HTMLGenerator {
    public static String generateHTML(String templateFile, String title, float classAvg, List<Student> students) throws Exception {
        // 템플릿 파일 읽기
        String template = new String(Files.readAllBytes(Paths.get(templateFile)), "UTF-8");

        // 테이블 행 생성
        StringBuilder rows = new StringBuilder();
        for (Student student : students) {
            rows.append("<tr>")
                    .append("<td>").append(student.getHakbun()).append("</td>")
                    .append("<td class='bold'>").append(student.getName()).append("</td>")
                    .append("<td class='bold'>").append(student.getGender()).append("</td>")
                    .append("<td>").append(student.getKor()).append("(").append(student.getKorGrade()).append(")").append("</td>")
                    .append("<td>").append(student.getEng()).append("(").append(student.getEngGrade()).append(")").append("</td>")
                    .append("<td>").append(student.getMath()).append("(").append(student.getMathGrade()).append(")").append("</td>")
                    .append("<td>").append(student.getOption()).append("(").append(student.getOptionGrade()).append(")").append("</td>")
                    .append("<td>").append(student.getSum()).append("</td>")
                    .append("<td>").append(String.format("%.2f", student.getAvg())).append("</td>")
                    .append("<td class='rank-cell'>").append(student.getClassRank()).append("</td>")
                    .append("<td class='rank-cell'>").append(student.getGradeRank()).append("</td>")
                    .append("</tr>");
        }

        // 템플릿의 마커를 실제 값으로 치환
        template = template.replace("${TITLE}", title)
                .replace("${CLASS_AVG}", String.format("%.2f", classAvg))
                .replace("${TABLE_ROWS}", rows.toString());
        return template;
    }
}
