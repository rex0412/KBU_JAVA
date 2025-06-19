import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner keyboard = new Scanner(System.in);

        // 계좌 생성
        Account myAccount = new Account("123456-78-912345", "12349876",
                "이대용", 788826.0, 2.5);

        System.out.println("=== 계좌 정보 ===");
        System.out.println(myAccount);

        // 입금 처리
        System.out.print("\n입금할 금액을 입력하세요 : ");
        double depositAmount = keyboard.nextDouble();

        myAccount.setBalance(myAccount.getBalance() + depositAmount);
        System.out.printf("%.2f원이 입금되었습니다. 현재 잔액: %.2f원\n",
                depositAmount, myAccount.getBalance());

        // 출금 처리
        System.out.print("\n출금할 금액을 입력하세요 : ");
        double withdrawAmount = keyboard.nextDouble();
        if (withdrawAmount > myAccount.getBalance()) {
            System.out.println("잔액이 부족하여 출금이 불가능합니다.");
        } else {
            myAccount.setBalance(myAccount.getBalance() - withdrawAmount);
            System.out.printf("%.2f원이 출금되었습니다. 현재 잔액: %.2f원\n",
                    withdrawAmount, myAccount.getBalance());
        }

        // 잔액 조회
        System.out.println("\n현재 잔액 조회 중···");
        System.out.printf("현재 잔액 : %.2f원\n", myAccount.getBalance());

        // 이율 조정
        System.out.print("\n새로운 이율을 입력하세요 : ");
        double newInterestRate = keyboard.nextDouble();
        myAccount.setInterestRate(newInterestRate);
        System.out.printf("이율이 %.2f%%로 변경되었습니다.\n", myAccount.getInterestRate());

        // 최종 계좌 정보 출력
        System.out.println("\n=== 최종 계좌 정보 ===");
        System.out.println(myAccount);
    }
}
