import java.util.Scanner;

public class Office {
    public static void main(String[] args) {
        Scanner keyboard = new Scanner(System.in);
        House[] users = new House[10]; // 최대 10명 처리

        for (int i = 0; i < users.length; i++) {
            System.out.print("번호를 입력하세요 : ");
            String number = keyboard.next();

            System.out.print("이름을 입력하세요 : ");
            String name = keyboard.next();

            char code;
            // 수도 구분 코드 유효성 검사
            while (true) {
                System.out.print("수도 구분 코드를 입력하세요 : ");
                code = keyboard.next().charAt(0);

                if (code >= '1' && code <= '5') {
                    break;  // 유효한 코드 입력시 반복문 종료
                } else {
                    System.err.println("Error : 수도 구분 코드는 1 ~ 5 사이의 값이어야 합니다.");
                }
            }

            System.out.print("사용량을 입력하세요 : ");
            double usage = keyboard.nextDouble();

            // 수도 구분 코드에 맞는 객체 생성
            switch (code) {
                case '1': users[i] = new Man(name, number, usage); break;
                case '2': users[i] = new Business(name, number, usage); break;
                case '3': users[i] = new Company(name, number, usage); break;
                case '4': users[i] = new Offices(name, number, usage); break;
                case '5': users[i] = new Army(name, number, usage); break;
            }
            System.out.println();  // 사용자 구분을 위해 빈 줄 출력
        }

        // 결과 출력
        printSummary(users);
    }

    // 결과 출력 메서드
    public static void printSummary(House[] users) {
        double totalUsage = 0;
        double totalCharge = 0;
        double totalTax = 0;
        double totalCollection = 0;

        line(); // 구분선 출력
        System.out.println("번호     이름     구분     사용량      사용금액      세금       납부액     비고");
        line(); // 구분선 출력

        // 사용자 정보 출력
        for (House user : users) {
            // 구분 코드를 한 번만 결정하고 변수에 저장
            char code = user instanceof Man ? '1' :
                    user instanceof Business ? '2' :
                            user instanceof Company ? '3' :
                                    user instanceof Offices ? '4' : '5';

            // 구분 출력: 수도 구분 코드에 따른 "가정용", "영업용", "공장용", "관공서", "군기관" 출력
            String category = "";
            switch (code) {
                case '1':
                    category = "가정용";
                    break;
                case '2':
                    category = "영업용";
                    break;
                case '3':
                    category = "공장용";
                    break;
                case '4':
                    category = "관공서";
                    break;
                case '5':
                    category = "군기관";
                    break;
            }

            // 비고 출력: 군기관일 경우 "일괄징수" 출력
            String remark = (code == '5') ? "일괄징수" : "";

            // toString 출력
            System.out.printf("%s    %s    %s   %.1f m³   %,d원    %,d원    %,d원       %s\n",
                    user.getNumber(), user.getName(), category, user.getUsage(),
                    (int) user.getCharge(code), (int) user.getTax(code),
                    (int) user.getCollection(code), remark);

            // 사용량, 요금, 세금, 납부액 계산
            totalUsage += user.getUsage();
            totalCharge += user.getCharge(code);
            totalTax += user.getTax(code);
            totalCollection += user.getCollection(code);
        }

        line(); // 구분선 출력
        System.out.printf("   사용량 합계: %.1f m³\n", totalUsage);
        System.out.printf("   요금  합계: %,d원\n", (int) totalCharge);
        System.out.printf("   세금  합계: %,d원\n", (int) totalTax);
        System.out.printf("   징수금 합계: %,d원\n", (int) totalCollection);
        line(); // 구분선 출력
    }

    // 구분선 출력 메서드
    private static void line() {
        System.out.println("-------------------------------------------------------------------------");
    }
}
