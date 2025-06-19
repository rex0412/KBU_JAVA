import java.io.*;

public class Main {
    public static void main(String[] args) {
        String path = ".\\data\\";  // 경로 지정
        String inputFileName = "source.txt";
        String outputFileName = "reverse.txt";

        try (
                // 경로(path)와 파일명을 결합하여 전체 경로 생성
                BufferedReader br = new BufferedReader(new FileReader(path + inputFileName));
                BufferedWriter bw = new BufferedWriter(new FileWriter(path + outputFileName))
        ) {
            String line;
            while ((line = br.readLine()) != null) {
                String reversed = new StringBuilder(line).reverse().toString();
                bw.write(reversed);
                bw.newLine();
            }
            System.out.println("파일 복사가 완료되었습니다.");
        } catch (IOException e) {
            System.out.print(e.getMessage());
        }
    }
}
