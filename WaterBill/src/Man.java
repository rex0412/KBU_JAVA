public class Man extends House {
    public Man(String name, String number, double usage) {
        super(name, number, usage);
    }

    @Override
    public String toString() {
        return super.toString() + String.format("  %.1f    %,d원    %,d원    %,d원",
                getUsage(), (int) getCharge('1'), (int) getTax('1'), (int) getCollection('1'));
    }
}
