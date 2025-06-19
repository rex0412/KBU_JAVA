import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        Customer[] customers = {
                new Company("5895", "이대용"),
                new Business("5567", "정확한"),
                new House("1365", "홍길동"),
                new House("3473", "이수한"),
                new Offices("5678", "이대한"),
                new House("5234", "정밀도"),
                new Company("3333", "이수도"),
                new House("5523", "김이천"),
                new Army("4564", "김천도"),
                new Army("4444", "김천지")
        };

        for (Customer c : customers) {
            c.inputData();  // 사용자로부터 사용량 입력
        }

        WaterOffice office = new WaterOffice();
        for (Customer c : customers) {
            office.addCustomer(c);
        }

        office.display();  // 결과 출력
    }
}
