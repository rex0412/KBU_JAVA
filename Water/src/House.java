public class House extends Customer {
    public House(String waterNo, String name) {
        super(waterNo, name);
    }

    @Override
    public int fee() {
        return Math.round(getUsed()) * 40;
    }

    @Override
    public int tax() {
        return (int) ((BASIC + fee()) * 0.05f);
    }

    @Override
    public int pay() {
        return BASIC + fee() + tax();
    }

    @Override
    public String toString() {
        return String.format("%s 가정용 %8.2f %,8d원 %,5d원 %,8d원",
                toSimpleString(), getUsed(), fee(), tax(), pay());
    }
}
