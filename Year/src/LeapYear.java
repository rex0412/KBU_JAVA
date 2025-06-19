public class LeapYear {
    private int year; // 연도를 저장하는 변수

    // 생성자: 연도를 입력받아 초기화
    public LeapYear(int year) {
        this.year = year;
    }

    // getter 메소드: 연도를 반환
    public int getYear() {
        return year;
    }

    // setter 메소드: 연도를 설정
    public void setYear(int year) {
        this.year = year;
    }

    // toString 메소드: 연도를 문자열로 반환

    @Override
    public String toString() {
        return "LeapYear { " +
                "연도 : " + year + "년 " +
                '}';
    }
}
