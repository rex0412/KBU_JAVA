public class Main {
    public static void main(String[] args) {
        Circle circle1 = new Circle(10);
        Circle circle2 = new Circle(10);

        // 반지름 값으로 직접 비교
        boolean isEqual = (circle1.getRadius() == circle2.getRadius());

        System.out.println(circle1);
        System.out.println(circle2);
        System.out.println("circle1과 circle2는 같습니까? : " + isEqual);
    }
}
