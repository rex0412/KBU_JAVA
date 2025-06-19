public class Person {
    private String waterNo;
    private String name;

    public Person(String waterNo, String name) {
        this.waterNo = waterNo;
        this.name = name;
    }

    public String getWaterNo() {
        return waterNo;
    }

    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return String.format("%4s %s", waterNo, name);
    }
}
