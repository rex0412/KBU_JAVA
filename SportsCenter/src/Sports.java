public class Sports {
    private String no;
    private String name;
    private String grade;
    private String sportName;
    private int period;
    private int basicFee;
    private int useFee;
    private int totalFee;
    private int bonus;

    public Sports(String no, String name, String grade, String sportName, int period, int basicFee, int useFee, int totalFee, int bonus) {
        this.no = no;
        this.name = name;
        this.grade = grade;
        this.sportName = sportName;
        this.period = period;
        this.basicFee = basicFee;
        this.useFee = useFee;
        this.totalFee = totalFee;
        this.bonus = bonus;
    }

    public String getNo() {
        return no;
    }

    public String getName() {
        return name;
    }

    public String getGrade() {
        return grade;
    }

    public String getSportName() {
        return sportName;
    }

    public int getPeriod() {
        return period;
    }

    public int getBasicFee() {
        return basicFee;
    }

    public int getUseFee() {
        return useFee;
    }

    public int getTotalFee() {
        return totalFee;
    }

    public int getBonus() {
        return bonus;
    }

    @Override
    public String toString() {
        return String.format("%-10s%-10s%-10s%-15s%-10d%,10d%,10d%,10d%,10d",
                no, name, grade, sportName, period, basicFee, useFee, totalFee, bonus);
    }
}
