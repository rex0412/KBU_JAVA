import java.util.*;

public class Grade {
    private String gradeName;
    private List<ClassRoom> classrooms = new ArrayList<>();

    public Grade(String gradeName) { this.gradeName = gradeName; }
    public void addClassRoom(ClassRoom classroom) { classrooms.add(classroom); }

    public void calculateGradeRank() {
        List<Student> allStudents = new ArrayList<>();
        for (ClassRoom cr : classrooms) allStudents.addAll(cr.getStudents());
        Collections.sort(allStudents);
        for (int i = 0; i < allStudents.size(); i++) {
            allStudents.get(i).setGradeRank(i + 1);
        }
    }

    public String getGradeName() { return gradeName; }
    public List<ClassRoom> getClassrooms() { return classrooms; }
}
