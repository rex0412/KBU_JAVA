public class SportsCenter {
    private final Sports[] members;

    public SportsCenter(Sports[] members) {
        this.members = members;
    }

    public void display() {
        System.out.println("------------------------------------------------------------------------------------------------------------------------");
        System.out.printf("%-10s%-10s%-10s%-15s%-12s%-12s%-12s%-12s%-12s\n",
                "회원번호", "이름", "등급", "운동종류명", "사용시간", "기본요금", "사용요금", "납부요금", "보너스");
        System.out.println("------------------------------------------------------------------------------------------------------------------------");

        for (Sports s : members) {
            System.out.printf("%-10s%-10s%-10s%-15s%-12d%,12d%,12d%,12d%,12d\n",
                    s.getNo(), s.getName(), s.getGrade(), s.getSportName(),
                    s.getPeriod(), s.getBasicFee(), s.getUseFee(), s.getTotalFee(), s.getBonus());
        }
        System.out.println("------------------------------------------------------------------------------------------------------------------------");
    }
}
