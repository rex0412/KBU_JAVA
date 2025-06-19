import java.util.*;

public class ClassRoom {
    private String name;
    private List<Student> students;

    public ClassRoom(String name) {
        this.name = name;
        this.students = new ArrayList<>();
    }

    public void addStudent(Student student) {
        students.add(student);
    }

    public void calculateRank() {
        students.sort((s1, s2) -> Integer.compare(s2.getSum(), s1.getSum()));
        for (int i = 0; i < students.size(); i++) {
            students.get(i).setRank(i + 1);
        }
    }

    public List<Student> getStudents() { return students; }
    public String getName() { return name; }
}
