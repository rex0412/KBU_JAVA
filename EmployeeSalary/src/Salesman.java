public class Salesman extends Employee {
    protected double sales;
    protected double commissionRate;
    protected int commission;

    public Salesman(String id, String name, char grade, double sales, double rate) {
        super(id, name);
        this.grade = grade;
        this.sales = sales;
        this.commissionRate = rate;
    }

    @Override
    public void computeSalary() {
        switch (grade) {
            case '1': base = 3_000_000; break;
            case '2': base = 2_500_000; break;
            case '3': base = 2_000_000; break;
            default: base = 0;
        }
        commission = (int)(sales * (commissionRate / 100));
        int gross = base + commission;
        tax = (int)(gross * 0.1);  // 세금 10%
        net = gross - tax;
    }

    @Override
    public void printData() {
        System.out.printf("%s   %s   %s      0       0       %,8d       %,8d       %,8d   영업직\n",
                id, name, formatGrade(), base, tax, net);
    }

    public void printCommissionData() {
        System.out.printf("%s   %s   %s   %,12.0f원   %.2f%%   %,8d원\n",
                id, name, formatGrade(), sales, commissionRate, commission);
    }
}
