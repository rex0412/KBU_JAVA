import java.io.File;
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        Scanner keyboard = new Scanner(System.in);

        // 반 생성 및 입력
        ClassRoom classA = inputStudents(keyboard, "A반");
        ClassRoom classB = inputStudents(keyboard, "B반");

        // 학년 석차 계산
        List<ClassRoom> classRooms = Arrays.asList(classA, classB);
        GradeRankCalculator.calculateGradeRank(classRooms);

        // PDF 생성
        PDFReport.generateReport(classRooms, "data/성적표.pdf");
        System.out.println("data/성적표.pdf 파일이 생성되었습니다!");
        keyboard.close();
    }

    private static ClassRoom inputStudents(Scanner keyboard, String className) {
        ClassRoom classroom = new ClassRoom(className);
        System.out.printf("[%s] 학생 수 입력: ", className);
        int count = keyboard.nextInt();
        keyboard.nextLine();  // 버퍼 비우기

        for (int i = 1; i <= count; i++) {
            System.out.printf("[%s] 학생 %d 정보 입력 (학번 이름 국어 영어 수학 선택과목): ", className, i);
            String line = keyboard.nextLine();
            String[] data = line.trim().split("\\s+");

            if (data.length != 6) {
                System.out.println("입력 형식이 잘못되었습니다. 다시 입력해주세요.");
                i--;
                continue;
            }

            try {
                Student student = new Student(
                        data[0],
                        data[1],
                        Integer.parseInt(data[2]),
                        Integer.parseInt(data[3]),
                        Integer.parseInt(data[4]),
                        Integer.parseInt(data[5])
                );
                classroom.addStudent(student);
            } catch (NumberFormatException e) {
                System.out.println("점수 입력이 잘못되었습니다. 다시 입력해주세요.");
                i--;
            }
        }
        classroom.calculateRank();
        return classroom;
    }
}
