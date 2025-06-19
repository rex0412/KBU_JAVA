public class PowerOffice {
    Person[] list;

    public PowerOffice(Person[] list) {
        this.list = list;
    }

    public void sort() {
        for (int i = 0; i < list.length - 1; i++) {
            for (int j = i + 1; j < list.length; j++) {
                if (list[i].totalPay() < list[j].totalPay()) {
                    Person temp = list[i];
                    list[i] = list[j];
                    list[j] = temp;
                }
            }
        }
    }

    public void display() {
        sort();
        Method method = new Method() {
            @Override
            public void line() {
                System.out.println("************************************************************************************");
            }
        };

        method.line();

        System.out.printf("%s      %s      %s      %s        %s        %s       %s\n",
                "번호", "이름", "사용량", "사용요금", "세금", "납부금액", "기타");
        method.line();

        int sumPower = 0, sumPay = 0, sumTax = 0, sumTotal = 0;

        for (Person p : list) {
            // 금액 출력 시 소수점 없애고 정수로 출력
            System.out.printf("%s     %s     %dKw     %,d원     %,d원     %,d원    %s\n",
                    p.getCode(), p.getName(), p.getPower(), (int)p.calcPrice(), (int)p.tax(), (int)p.totalPay(), p.getEtc());

            sumPower += p.getPower();
            sumPay += p.calcPrice();
            sumTax += p.tax();
            sumTotal += p.totalPay();
        }

        method.line();
        System.out.printf("     사용량 합계 : %dKw\n", sumPower);
        System.out.printf("     요금   합계 : %,d원\n", sumPay);
        System.out.printf("     세금   합계 : %,d원\n", sumTax);
        System.out.printf("     수납   합계 : %,d원\n", sumTotal);
        method.line();
    }
}
