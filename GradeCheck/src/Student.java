import java.util.List;

public class Student extends Person {
    private String department;
    private List<Subject> subjects;
    private int majorRank;

    public Student(String name, String id, String department, List<Subject> subjects) {
        super(name, id);
        this.department = department;
        this.subjects = subjects;
    }

    public double getMajorAverage() {
        return subjects.stream()
                .filter(s -> s instanceof MajorSubject)
                .mapToInt(Subject::getScore)
                .average()
                .orElse(0.0);
    }

    public double getTotalAverage() {
        return subjects.stream()
                .mapToInt(Subject::getScore)
                .average()
                .orElse(0.0);
    }

    public void setMajorRank(int rank) { this.majorRank = rank; }
    public int getMajorRank() { return majorRank; }

    public void displayInfo(ClassRoom classRoom) {
        System.out.printf("학번: %s, 이름: %s, 학과: %s\n", getId(), getName(), department);
        System.out.println("--------------------------------------------------");
        System.out.println("[전공 과목 성적]");
        for (Subject s : subjects) {
            if (s instanceof MajorSubject) {
                System.out.printf("- %s: %d점 (%s)\n", s.getSubjectName(), s.getScore(), s.isPassed() ? "통과" : "낙제");
            }
        }
        System.out.println();
        System.out.println("[교양 과목 성적]");
        for (Subject s : subjects) {
            if (s instanceof GeneralSubject) {
                System.out.printf("- %s: %d점 (%s)\n", s.getSubjectName(), s.getScore(), s.isPassed() ? "통과" : "낙제");
            }
        }
        System.out.println();
        System.out.printf("전공 평균: %.1f\n", getMajorAverage());
        System.out.printf("전체 평균: %.1f\n", getTotalAverage());
        System.out.printf("등수 : %d명 중에 %d등\n", classRoom.getStudentCount(), getMajorRank());
    }
}
