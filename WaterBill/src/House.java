public class House {
    private final String name;
    private final String number;
    private final double usage;
    private final double basicCharge = 1200; // 기본요금

    public House(String name, String number, double usage) {
        this.name = name;
        this.number = number;
        this.usage = usage;
    }

    public String getName() {
        return name;
    }

    public String getNumber() {
        return number;
    }

    public double getUsage() {
        return usage;
    }

    public double getBasicCharge() {
        return basicCharge;
    }

    // 수도 구분 코드에 따른 요금과 세금 계산
    public double[] calculateChargeAndTax(char code) {
        double rate = 0;   // 요금
        double tax = 0;    // 세금

        // 수도 구분 코드에 따른 요금 및 세금 계산
        switch (code) {
            case '1': // 가정용
                rate = 40;
                tax = (basicCharge + (usage * rate)) * 0.05; // 5% 세금
                break;
            case '2': // 영업용
                rate = 55;
                tax = (basicCharge + (usage * rate)) * 0.035; // 3.5% 세금
                break;
            case '3': // 공장용
                rate = 78;
                tax = (basicCharge + (usage * rate)) * 0.025; // 2.5% 세금
                break;
            case '4': // 관공서
                rate = 35;
                tax = (basicCharge + (usage * rate)) * 0.015; // 1.5% 세금
                break;
            case '5': // 군기관
                rate = 20;
                tax = 0; // 세금 없음
                break;
            default:
                System.out.println("잘못된 수도 구분 코드입니다.");
                break;
        }

        // 요금과 세금을 배열로 반환
        return new double[] { rate * usage, tax };
    }

    public double getCharge(char code) {
        return calculateChargeAndTax(code)[0];
    }

    public double getTax(char code) {
        return calculateChargeAndTax(code)[1];
    }

    public double getCollection(char code) {
        return basicCharge + getCharge(code) + getTax(code);
    }

    // 각 하위 클래스에서 오버라이드할 toString 메서드
    @Override
    public String toString() {
        return String.format("%s    %s  %s  %.1f", number, name, getClass().getSimpleName(), usage);
    }
}
