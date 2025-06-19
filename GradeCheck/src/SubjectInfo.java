public class SubjectInfo {
    private String code;
    private String name;
    private String type;
    private int credit;

    public SubjectInfo(String code, String name, String type, int credit) {
        this.code = code;
        this.name = name;
        this.type = type;
        this.credit = credit;
    }

    public String getCode() { return code; }
    public String getName() { return name; }
    public String getType() { return type; }
}
