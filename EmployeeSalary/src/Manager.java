public class Manager extends Employee {
    private double incentive;

    public Manager(String id, String name, char grade, double incentive) {
        super(id, name);
        this.grade = grade;
        this.incentive = incentive;
    }

    @Override
    public void computeSalary() {
        switch (grade) {
            case '1': base = 3_000_000; break;
            case '2': base = 2_500_000; break;
            case '3': base = 2_000_000; break;
            default: base = 0;
        }
        int gross = base + (int)incentive;
        tax = (int)(gross * 0.1);  // 세금 10%
        net = gross - tax;
    }

    @Override
    public void printData() {
        System.out.printf("%s   %s   %s      0       0       %,8d       %,8d       %,8d   점장직\n",
                id, name, formatGrade(), base, tax, net);
    }
}
