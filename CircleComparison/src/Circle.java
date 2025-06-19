public class Circle {
    private int radius; // 반지름 필드

    // 생성자 (반지름을 인자로 받아 초기화)
    public Circle(int radius) {
        this.radius = radius;
    }

    // 반지름의 getter 메소드
    public int getRadius() {
        return radius;
    }

    // 반지름의 setter 메소드
    public void setRadius(int radius) {
        this.radius = radius;
    }

    @Override
    public String toString() {
        return "Circle { " +
                "반지름 : " + radius + " " +
                '}';
    }
}
