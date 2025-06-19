public class MajorSubject extends Subject {
    public MajorSubject(String name, int score, String code) {
        super(name, score, code);
    }

    @Override
    public boolean isPassed() {
        return getScore() >= 60;
    }
}
