public class GeneralSubject extends Subject {
    public GeneralSubject(String name, int score, String code) {
        super(name, score, code);
    }

    @Override
    public boolean isPassed() {
        return getScore() >= 70;
    }
}
