public class Offices extends Customer {
    public Offices(String waterNo, String name) {
        super(waterNo, name);
    }

    @Override
    public int fee() {
        return Math.round(getUsed()) * 35;
    }

    @Override
    public int tax() {
        return (int) ((BASIC + fee()) * 0.015f);
    }

    @Override
    public int pay() {
        return BASIC + fee() + tax();
    }

    @Override
    public String toString() {
        return String.format("%s 관공서 %8.2f %,8d원 %,5d원 %,8d원",
                toSimpleString(), getUsed(), fee(), tax(), pay());
    }
}
