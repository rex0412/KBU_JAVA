public abstract class Subject {
    private String name;
    private int score;
    private String code;

    public Subject(String name, int score, String code) {
        this.name = name;
        this.score = score;
        this.code = code;
    }

    public String getSubjectName() {
        return name;
    }

    public int getScore() { return score; }
    public String getCode() { return code; }

    public abstract boolean isPassed();

    public void displayInfo() {
        System.out.printf("- %s (%s): %d점 → %s\n",
                name, code, score, isPassed() ? "합격" : "낙제");
    }
}
