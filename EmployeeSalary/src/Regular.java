public class Regular extends Employee {
    public Regular(String id, String name, char grade) {
        super(id, name);
        this.grade = grade;
    }

    @Override
    public void computeSalary() {
        switch (grade) {
            case '1': base = 3_000_000; break;
            case '2': base = 2_500_000; break;
            case '3': base = 2_000_000; break;
            default: base = 0;
        }
        tax = (int)(base * 0.1);  // 세금 10%
        net = base - tax;
    }

    @Override
    public void printData() {
        System.out.printf("%s   %s   %s      0       0       %,8d       %,8d       %,8d\n",
                id, name, formatGrade(), base, tax, net);
    }
}
