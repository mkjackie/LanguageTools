package generators;


public class LexerParserGenerator {

	public static String targetDir = "src//lang_processor";
	
	public static void main(String[] args) throws Exception {
		
		generateLexer("simple.flex");
		generateParser("simple.cup");
	}
	
	private static void generateLexer(String flexFile) {
		
		flexFile = "src//generators//" + flexFile;
		
		String[] args = {"-d", targetDir, flexFile};
		
		jflex.Main.main(args);
	}
	
	private static void generateParser(String cupFile) throws Exception {
		
		cupFile = "src//generators//" + cupFile;
		
		String[] args = {"-destdir", targetDir, 
						 "-parser", "Parser", 
						 "-package", "lang_processor",
						 "-symbols", "TokenType",
						 cupFile};
		
		java_cup.Main.main(args);
		
	}
}
