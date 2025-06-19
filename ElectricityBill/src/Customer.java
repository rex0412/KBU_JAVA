public class Customer extends Person {
    public Customer(String code, String name) {
        super(code, name);
    }

    @Override
    public int calcPrice() {
        int power = getPower();
        int price = 1660;  // 기본 요금
        int additionalPrice = 0;

        // 100 Kw 이하, 100Kw 이상 구간별 요금 적용
        if (power <= 100) {
            additionalPrice = (int)(power * 184.1);  // 100Kw 이하
        } else if (power <= 200) {
            additionalPrice = (int)((100 * 184.1) +
                    ((power - 100) * 223.8));  // 100Kw 이상 200Kw 이하
        } else if (power <= 300) {
            additionalPrice = (int)((100 * 184.1) +
                    (100 * 223.8) + ((power - 200) * 278.3));  // 200Kw 이상 300Kw 이하
        } else if (power <= 400) {
            additionalPrice = (int)((100 * 184.1) +
                    (100 * 223.8) + (100 * 278.3) +
                    ((power - 300) * 353.6));  // 300Kw 이상 400Kw 이하
        } else if (power <= 500) {
            additionalPrice = (int)((100 * 184.1) +
                    (100 * 223.8) + (100 * 278.3) +
                    (100 * 353.6) + ((power - 400) * 466.4));  // 400Kw 이상 500Kw 이하
        } else {
            additionalPrice = (int)((100 * 184.1) + (100 * 223.8) +
                    (100 * 278.3) + (100 * 353.6) + (100 * 466.4) +
                    ((power - 500) * 643.9));  // 500Kw 이상
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
        return "";  // 일반 가구
    }
}
