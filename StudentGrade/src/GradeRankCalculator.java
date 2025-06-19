import java.util.*;

public class GradeRankCalculator {
    public static void calculateGradeRank(List<ClassRoom> classrooms) {
        List<Student> allStudents = new ArrayList<>();
        for (ClassRoom cr : classrooms) {
            allStudents.addAll(cr.getStudents());
        }

        allStudents.sort((s1, s2) -> Integer.compare(s2.getSum(), s1.getSum()));
        for (int i = 0; i < allStudents.size(); i++) {
            allStudents.get(i).setGradeRank(i + 1);
        }
    }
}
