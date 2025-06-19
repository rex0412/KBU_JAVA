public class Person {
    private String name; // String 문자열 타입
    private int age;
    private String gender;

    public Person(String name) {
        this("", 0, "");
    }

    public Person(String name, int age, String gender) {
        this.name = name;
        this.age = age;
        this.gender = gender;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

//        public String toString() {
//        return ("이름은 " + name + "이고, 나이는 " + age + "살의 " + gender + "가 있습니다.");
//    }

    @Override
    public String toString() {
        return "Person { " +
                "이름은 '" + name + '\'' +
                "이고, 나이는 " + age +
                "살의 '" + gender + '\'' +
                "가 있습니다." + " " +
                '}';
    }
}
