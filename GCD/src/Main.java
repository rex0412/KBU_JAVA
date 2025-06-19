import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        // Scanner 객체로 입력 받기
        Scanner keyboard = new Scanner(System.in);
        System.out.print("자연수 2개 입력 : ");
        int num1 = keyboard.nextInt();
        int num2 = keyboard.nextInt();

        // GCD 계산
        int gcd = calculateGCD(num1, num2);

        // GCD 객체 생성 후 계산된 GCD 값 설정
        GCD gcdObject = new GCD(num1, num2, gcd);  // GCD 객체 생성 시 GCD 값 전달

        // 결과 출력
        System.out.println(gcdObject);
    }

    // 최대공약수 계산 메소드
    public static int calculateGCD(int num1, int num2) {
        while (num2 != 0) {
            int temp = num2;
            num2 = num1 % num2;
            num1 = temp;
        }
        return num1;
    }
}
