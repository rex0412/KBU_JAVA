public class Student extends Person implements Comparable<Student> {
    private int kor, eng, math, option;
    private int sum;
    private float avg;
    private int classRank;
    private int gradeRank;

    public Student() { super(); }

    public Student(String hakbun, String name, char gender, int kor, int eng, int math, int option) {
        super(hakbun, name, gender);
        this.kor = kor;
        this.eng = eng;
        this.math = math;
        this.option = option;
        calculateSum();
        calculateAvg();
    }

    public void calculateSum() { sum = kor + eng + math + option; }
    public void calculateAvg() { avg = (float)(Math.round((sum / 4.0) * 100) / 100.0); }

    // 평점 계산 메서드
    public String getKorGrade() {
        switch (kor / 10) {
            case 10: case 9: return "수";
            case 8: return "우";
            case 7: return "미";
            case 6: return "양";
            default: return "가";
        }
    }

    public String getEngGrade() { return getLetterGrade(eng); }
    public String getMathGrade() { return getLetterGrade(math); }
    private String getLetterGrade(int score) {
        if (score >= 95) return "A+";
        else if (score >= 90) return "A0";
        else if (score >= 85) return "B+";
        else if (score >= 80) return "B0";
        else if (score >= 75) return "C+";
        else if (score >= 70) return "C0";
        else if (score >= 65) return "D+";
        else if (score >= 60) return "D0";
        else return "F";
    }

    public String getOptionGrade() {
        if (option >= 90) return "A";
        else if (option >= 80) return "B";
        else if (option >= 70) return "C";
        else if (option >= 60) return "D";
        else return "F";
    }

    @Override
    public int compareTo(Student o) { return o.sum - this.sum; }

    // Getter & Setter
    public int getKor() { return kor; }
    public int getEng() { return eng; }
    public int getMath() { return math; }
    public int getOption() { return option; }
    public int getSum() { return sum; }
    public float getAvg() { return avg; }
    public int getClassRank() { return classRank; }
    public void setClassRank(int classRank) { this.classRank = classRank; }
    public int getGradeRank() { return gradeRank; }
    public void setGradeRank(int gradeRank) { this.gradeRank = gradeRank; }
}
