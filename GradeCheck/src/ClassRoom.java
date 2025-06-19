import java.util.*;

public class ClassRoom {
    private List<Student> students;

    public ClassRoom(List<Student> students, Map<String, SubjectInfo> subjectInfoMap) {
        this.students = students;
        calculateRanks();
    }

    public int getStudentCount() {
        return students.size();
    }

    public Student findStudentById(String id) {
        return students.stream()
                .filter(s -> s.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    private void calculateRanks() {
        students.sort(Comparator.comparingDouble(Student::getMajorAverage).reversed());
        for (int i = 0; i < students.size(); i++) {
            students.get(i).setMajorRank(i + 1);
        }
    }
}
