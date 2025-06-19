public class Special extends Person {
    public Special(String code, String name) {
        super(code, name);
    }

    @Override
    public int calcPrice() {
        int power = getPower();
        int price = 1660;  // 기본 요금
        int additionalPrice = 0;

        // 지원 가구는 100Kw까지 무료
        if (power <= 100) {
            additionalPrice = 0;  // 무료
        } else {
            additionalPrice = (int)((power - 100) * 184.1);  // 100Kw 초과는 184.1원
        }

        return price + additionalPrice;  // 기본 요금 + 사용량에 따른 요금
    }

    @Override
    public int tax() {
        return (int)(calcPrice() * 0.07);  // 7% 세금
    }

    @Override
    public int totalPay() {
        return calcPrice() + tax();  // 사용 요금 + 세금
    }

    @Override
    public String getEtc() {
        return "지원가구";  // 지원 가구
    }
}
