public class Army extends House {
    public Army(String name, String number, double usage) {
        super(name, number, usage);
    }

    @Override
    public String toString() {
        return super.toString() + String.format("  %.1f    %,d원    %,d원    %,d원",
                getUsage(), (int) getCharge('5'), (int) getTax('5'), (int) getCollection('5'));
    }
}
