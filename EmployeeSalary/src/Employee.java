public abstract class Employee {
    protected String id, name;
    protected char grade;
    protected int base; // 기본급
    protected int net;  // 실 지급액
    protected int tax;  // 세금

    public Employee(String id, String name) {
        this.id = id;
        this.name = name;
    }

    public String formatGrade() {
        return grade == '-' ? " 급" : grade + "급";
    }

    public abstract void computeSalary();

    public abstract void printData();
}
