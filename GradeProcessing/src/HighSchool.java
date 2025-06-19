public class HighSchool extends Student {
    public HighSchool() {
        super();
    }

    public HighSchool(String hakbun, String name, int kor, int eng, int math, int sum, float avg, int rank) {
        super(hakbun, name, kor, eng, math, sum, avg, rank);
    }

    public String grade(int score) {
        if (score >= 90) return "수";
        else if (score >= 80) return "우";
        else if (score >= 70) return "미";
        else if (score >= 60) return "양";
        return "가";
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