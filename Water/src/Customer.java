import java.io.IOException;
import java.util.Scanner;

public abstract class Customer implements Method {
    private String waterNo;  // 수용가 번호
    private String name;     // 이름
    protected float used;    // 수도 사용량

    public Customer(String waterNo, String name) {
        this.waterNo = waterNo;
        this.name = name;
    }

    public String getWaterNo() {
        return waterNo;
    }

    public String getName() {
        return name;
    }

    public float getUsed() {
        return used;
    }

    public void inputData() throws IOException {
        Scanner keyboard = new Scanner(System.in);
        while (true) {
            System.out.printf("%s님의 수도 사용량 입력 : ", getName());
            used = keyboard.nextFloat();
            if (used >= 0.0f && used <= 999.9f) {
                break;
            } else {
                System.err.println("ERROR: 사용량은 0.0 ~ 999.9 범위여야 합니다.");
            }
        }
    }

    public String toSimpleString() {
        return String.format("%4s %-5s", waterNo, name);
    }

    @Override
    public String toString() {
        return String.format("%s %6.2f", getWaterNo(), getName(), used);
    }
}