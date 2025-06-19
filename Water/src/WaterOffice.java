import java.util.ArrayList;
import java.util.List;

public class WaterOffice {
    private List<Customer> customers = new ArrayList<>();

    public void addCustomer(Customer c) {
        customers.add(c);
    }

    private void sort() {
        for (int i = 0; i < customers.size(); i++) {
            for (int j = i + 1; j < customers.size(); j++) {
                if (customers.get(i).pay() < customers.get(j).pay()) {  // 내림차순
                    Customer temp = customers.get(i);
                    customers.set(i, customers.get(j));
                    customers.set(j, temp);
                }
            }
        }
    }

    public void display() {
        sort();

        double totalUsed = 0.0;
        int totalFee = 0;
        int totalTax = 0;
        int totalPay = 0;

        System.out.println("\t\t\t 수 도 요 금");
        line();
        System.out.println("번호   이름   구분   사용양   사용금액   TAX   납부액   비고");
        line();

        for (Customer c : customers) {
            System.out.println(c);
            totalUsed += c.getUsed();
            totalFee += c.fee();
            totalTax += c.tax();
            totalPay += c.pay();
        }

        line();
        System.out.printf("  사용량 합계 : %,10.2f\n", totalUsed);
        System.out.printf("  요금    합계 : %,8d원\n", totalFee);
        System.out.printf("  세금    합계 : %,8d원\n", totalTax);
        System.out.printf("  징수금 합계 : %,8d원\n", totalPay);
        line();
    }

    private void line() {
        System.out.println("------------------------------------------------------------------------");
    }
}
