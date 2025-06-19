public class Student {
    // 필드(속성)
    private String name;
    private int rollno;
    private int age;

    // 생성자
    public Student(String name, int rollno, int age) {
        this.name = name;
        this.rollno = rollno;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getRollno() {
        return rollno;
    }

    public void setRollno(int rollno) {
        this.rollno = rollno;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    @Override
    public String toString() {
        return "Student { " +
                "이름은 '" + name + '\'' +
                "이고, 학번은 " + rollno +
                "이며, 나이는 " + age + "입니다. " +
                '}';
    }
}
