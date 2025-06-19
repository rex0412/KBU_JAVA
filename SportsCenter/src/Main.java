import java.io.IOException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner keyboard = new Scanner(System.in);

        Sports[] man = new Sports[10]; // 회원 수 10명으로 고정

        for (int i = 0; i < man.length; i++) {
            System.out.print("회원번호를 입력하세요 : ");
            String no = keyboard.nextLine();

            System.out.print("회원이름을 입력하세요 : ");
            String name = keyboard.nextLine();

            System.out.print("회원등급코드를 입력하세요 : ");
            String grade = gradeToString(keyboard.next().charAt(0));
            keyboard.nextLine(); // 버퍼 비우기

            System.out.print("운동종류코드를 입력하세요 : ");
            String sportName = sportCodeToName(keyboard.next().charAt(0));
            keyboard.nextLine(); // 버퍼 비우기

            System.out.print("사용시간을 입력하세요 : ");
            int period = keyboard.nextInt();
            keyboard.nextLine(); // 버퍼 비우기
            System.out.println();

            // 기본 요금 및 사용 요금 계산
            int basicFee = gradeToFee(grade);
            int useFee = period * codeToPrice(sportName);
            int totalFee = basicFee + useFee;
            int bonus = (int) (useFee * 0.01); // 사용요금의 1%

            // Sports 객체 생성
            man[i] = new Sports(no, name, grade, sportName, period, basicFee, useFee, totalFee, bonus);
        }

        // 화면 지우기
        clearScreen();

        // SportsCenter를 이용해 출력
        SportsCenter sportsCenter = new SportsCenter(man);
        sportsCenter.display();
    }

    public static String gradeToString(char gradeCode) {
        switch (gradeCode) {
            case 'A': return "A등급";
            case 'B': return "B등급";
            case 'C': return "C등급";
            case 'D': return "D등급";
            default: return "알 수 없음";
        }
    }

    public static String sportCodeToName(char code) {
        switch (code) {
            case '1': return "스쿼시";
            case '2': return "테니스";
            case '3': return "골프";
            case '4': return "탁구";
            case '5': return "에어로빅";
            case '6': return "헬스";
            default: return "알 수 없음";
        }
    }

    public static int gradeToFee(String grade) {
        switch (grade) {
            case "A등급": return 4000;
            case "B등급": return 6000;
            case "C등급": return 9000;
            case "D등급": return 12000;
            default: return 0;
        }
    }

    public static int codeToPrice(String sportName) {
        switch (sportName) {
            case "스쿼시": return 4000;
            case "테니스": return 6000;
            case "골프": return 7000;
            case "탁구": return 5000;
            case "에어로빅": return 8000;
            case "헬스": return 10000;
            default: return 0;
        }
    }

    public static void clearScreen() {
        try {
            if (System.getProperty("os.name").contains("Windows")) {
                new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
            } else {
                System.out.print("\033[H\033[2J");
                System.out.flush();
            }
        } catch (IOException | InterruptedException e) {
            System.out.println("화면을 지우는 데 문제가 발생했습니다.");
        }
    }
}
