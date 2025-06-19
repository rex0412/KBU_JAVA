public class Temporary extends Employee {
    private int days;
    private int dailyWage;

    public Temporary(String id, String name, int days, int dailyWage) {
        super(id, name);
        this.days = days;
        this.dailyWage = dailyWage;
        this.grade = '-';
    }

    @Override
    public void computeSalary() {
        base = days * dailyWage;
        tax = (int)(base * 0.1);  // 세금 10%
        net = base - tax;
    }

    @Override
    public void printData() {
        System.out.printf("%s   %s   %s   %4d   %,6d       %,8d       %,8d       %,8d   일당제\n",
                id, name, formatGrade(), days, dailyWage, base, tax, net);
    }
}
