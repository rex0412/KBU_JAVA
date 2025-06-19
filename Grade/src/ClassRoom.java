import java.util.*;

public class ClassRoom {
    private String className;
    private List<Student> students = new ArrayList<>();

    public ClassRoom(String className) { this.className = className; }

    public void addStudent(Student student) { students.add(student); }

    public void calculateClassRank() {
        Collections.sort(students);
        for (int i = 0; i < students.size(); i++) {
            students.get(i).setClassRank(i + 1);
        }
    }

    public float getClassAverage() {
        if (students.isEmpty()) return 0;
        float total = 0;
        for (Student s : students) total += s.getAvg();
        return (float)(Math.round((total / students.size()) * 100) / 100.0);
    }

    public String getClassName() { return className; }
    public List<Student> getStudents() { return students; }
}
