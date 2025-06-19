import java.util.Scanner;

public abstract class Person {
    private String code;
    private String name;
    private int power;  // 전기사용량

    public Person(String code, String name) {
        this.code = code;
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public String getName() {
        return name;
    }

    public int getPower() {
        return power;
    }

    public void setPower(int power) {
        this.power = power;
    }

    // 전기사용량을 입력받는 메소드
    public void inputData() {
        Scanner keyboard = new Scanner(System.in);
        System.out.printf("%s 고객의 사용량 입력: ", this.getName());
        this.setPower(keyboard.nextInt());
    }

    // 기본 요금 계산 및 기타 메소드들을 선언 (calcPrice, tax, totalPay 등)
    public abstract int calcPrice();
    public abstract int tax();
    public abstract int totalPay();
    public abstract String getEtc();
}
