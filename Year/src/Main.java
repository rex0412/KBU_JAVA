import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        // Scanner를 사용하여 사용자로부터 연도 입력 받기
        Scanner keyboard = new Scanner(System.in);

        System.out.print("연도를 입력하세요 : ");
        int yearInput = keyboard.nextInt(); // 사용자가 입력한 연도

        // LeapYear 객체 생성
        LeapYear leapYear = new LeapYear(yearInput);

        // 윤년 여부를 판별하는 로직을 Main 클래스에서 수행
        int year = leapYear.getYear();
        boolean isLeapYear = false;

        if (year % 400 == 0) {
            isLeapYear = true;
        } else if (year % 100 == 0) {
            isLeapYear = false;
        } else if (year % 4 == 0) {
            isLeapYear = true;
        } else {
            isLeapYear = false;
        }

        // 윤년 여부를 출력
        if (isLeapYear) {
            System.out.println(leapYear + "은 윤년입니다.");
        } else {
            System.out.println(leapYear + "은 평년입니다.");
        }
    }
}