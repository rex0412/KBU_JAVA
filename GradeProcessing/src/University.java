public class University extends Student {
    public University() {
        super();
    }

    public University(String hakbun, String name, int kor, int eng, int math, int sum, float avg, int rank) {
        super(hakbun, name, kor, eng, math, sum, avg, rank);
    }

    public String grade(int score) {
        if (score >= 95) return "A+";
        else if (score >= 90) return "A0";
        else if (score >= 85) return "B+";
        else if (score >= 80) return "B0";
        else if (score >= 75) return "C+";
        else if (score >= 70) return "C0";
        return "D+";
    }

    @Override
    public void display() {
        System.out.printf("대학  %7s   %s   %d(%2s)   %d(%2s)   %d(%2s)   %d   %.2f     %d\n",
                getHakbun(), getName(),
                getKor(), grade(getKor()),
                getEng(), grade(getEng()),
                getMath(), grade(getMath()),
                getSum(), getAvg(), getRank());
    }
}
