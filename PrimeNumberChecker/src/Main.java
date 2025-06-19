import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        // Scanner 객체로 입력 받기
        Scanner keyboard = new Scanner(System.in);
        System.out.print("자연수 입력 : ");
        int inputNumber = keyboard.nextInt();

        // 소수 판별 결과 처리
        boolean isPrime = true;
        for (int i = 2; i <= inputNumber / 2; i++) {  // 절반까지만 나누어 봄
            if (inputNumber % i == 0) {
                isPrime = false;
                break;
            }
        }

        String result;
        if (inputNumber <= 1) {
            result = "합성수(Composite Number)입니다.";
        } else if (isPrime) {
            result = "소수(Prime Number)입니다.";
        } else {
            result = "합성수(Composite Number)입니다.";
        }

        // PrimeNumberChecker 객체 생성 및 결과 출력
        PrimeNumberChecker checker = new PrimeNumberChecker(inputNumber, result);
        System.out.println(checker.toString());
    }
}
