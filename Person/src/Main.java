public class Main {
    public static void main(String[] args) {
        Person person = new Person("이대용", 27, "남자");

        person.setName("이대용");
        person.setAge(person.getAge() + 1);

        System.out.println(person.getName() + "/" +
                person.getGender() + "/" + person.getAge());
        System.out.println(person);
    }
}