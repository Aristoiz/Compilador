public class ExecuteJFlex {
    public static void main(String omega[]) {
        String lexerFile = System.getProperty("user.dir") + "/src/main/java/Lexer.flex",
            lexerColor = System.getProperty("user.dir") + "/src/main/java/LexerColor.flex";
        try {
            jflex.Main.generate(new String[]{lexerFile});
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
