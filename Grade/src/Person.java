public class Person {
    private String hakbun;
    private String name;
    private char gender;

    public Person() {}

    public Person(String hakbun, String name, char gender) {
        this.hakbun = hakbun;
        this.name = name;
        this.gender = gender;
    }

    public String getHakbun() { return hakbun; }
    public void setHakbun(String hakbun) { this.hakbun = hakbun; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public char getGender() { return gender; }
    public void setGender(char gender) { this.gender = gender; }
}
