public class ClassRoom {
    private Student[] students;

    public ClassRoom(Student[] students) {
        this.students = students;
    }

    private void sort() {
        for (int i = 0; i < students.length - 1; i++) {
            for (int j = i + 1; j < students.length; j++) {
                if (students[i].getSum() < students[j].getSum()) {
                    Student temp = students[i];
                    students[i] = students[j];
                    students[j] = temp;
                }
            }
        }
    }

    public void display() {
        sort(); // 평균 기준 내림차순 정렬
        line();
        System.out.print("      학번      이름    국어       영어       수학      총점     평균      석차\n");
        line();
        for (Student s : students) {
            s.display(); // 각 클래스에서 override한 display() 사용
        }
        line();
    }

    private void line() {
        System.out.println("**************************************************************************");
    }
}
