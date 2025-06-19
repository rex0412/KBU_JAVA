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

        // LCM 계산
        int lcm = calculateLCM(num1, num2, gcd);

        // GCDAndLCM 객체 생성 후 계산된 GCD와 LCM 값 설정
        GCDAndLCM gcdLcmObject = new GCDAndLCM(num1, num2, gcd, lcm);

        // 결과 출력
        System.out.println(gcdLcmObject);  // 최대공약수 및 최소공배수 출력
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

    // 최소공배수 계산 메소드
    public static int calculateLCM(int num1, int num2, int gcd) {
        return (num1 * num2) / gcd;
    }
}
