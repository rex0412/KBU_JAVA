public class Army extends Customer {
    public Army(String waterNo, String name) {
        super(waterNo, name);
    }

    @Override
    public int fee() {
        return Math.round(getUsed()) * 20;
    }

    @Override
    public int tax() {
        return 0;
    }

    @Override
    public int pay() {
        return BASIC + fee();
    }

    @Override
    public String toString() {
        return String.format("%s 군기관 %8.2f %,8d원 %,5d원 %,8d원 일괄징수",
                toSimpleString(), getUsed(), fee(), tax(), pay());
    }
}
