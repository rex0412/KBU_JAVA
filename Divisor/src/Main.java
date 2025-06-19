import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        // Scanner 객체로 입력 받기
        Scanner keyboard = new Scanner(System.in);
        System.out.print("자연수 입력 : ");
        int number = keyboard.nextInt();

        // 약수와 합 계산
        int divisorSum = 0;
        String divisor = "";

        for (int i = 1; i <= number; i++) {
            if (number % i == 0) {  // 약수라면
                if (divisor.isEmpty()) {
                    divisor += i;  // 첫 번째 약수는 그대로 추가
                } else {
                    divisor += ", " + i;  // 그 이후의 약수는 ", "를 붙여서 추가
                }
                divisorSum += i;  // 약수의 합 계산
            }
        }

        // Divisor 객체 생성 (매개변수로 number, divisor, divisorSum 전달)
        Divisor divisorObj = new Divisor(number, divisor, divisorSum);

        // 결과 출력
        System.out.println(divisorObj.toString());
    }
}
