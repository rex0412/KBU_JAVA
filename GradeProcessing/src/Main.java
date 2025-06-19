public class Main {
    public static void main(String[] args) {
        Student[] students = new Student[10];

        students[0] = new HighSchool();
        students[1] = new HighSchool();
        students[2] = new University();
        students[3] = new HighSchool();
        students[4] = new HighSchool();
        students[5] = new University();
        students[6] = new HighSchool();
        students[7] = new HighSchool();
        students[8] = new HighSchool();
        students[9] = new HighSchool();

        for (int i = 0; i < students.length; i++) {
            students[i].inputData();     // 입력
            students[i].calculate();     // 합계/평균 계산
        }

        ClassRoom classRoom = new ClassRoom(students);
        classRoom.display();
    }
}