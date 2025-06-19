public class Student {
    private String hakbun;
    private String name;
    private int kor, eng, math, option;
    private int sum;
    private double avg;
    private int rank;       // 반 등수
    private int gradeRank;  // 학년 석차

    public Student(String hakbun, String name, int kor, int eng, int math, int option) {
        this.hakbun = hakbun;
        this.name = name;
        this.kor = kor;
        this.eng = eng;
        this.math = math;
        this.option = option;
        calculateSumAvg();
    }

    private void calculateSumAvg() {
        this.sum = kor + eng + math + option;
        this.avg = sum / 4.0;
    }

    // Getters
    public String getHakbun() { return hakbun; }
    public String getName() { return name; }
    public int getKor() { return kor; }
    public int getEng() { return eng; }
    public int getMath() { return math; }
    public int getOption() { return option; }
    public int getSum() { return sum; }
    public double getAvg() { return avg; }
    public int getRank() { return rank; }
    public int getGradeRank() { return gradeRank; }

    // Setters
    public void setRank(int rank) { this.rank = rank; }
    public void setGradeRank(int gradeRank) { this.gradeRank = gradeRank; }
}
