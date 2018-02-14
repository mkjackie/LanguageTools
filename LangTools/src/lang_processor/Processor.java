package lang_processor;

import java.io.FileNotFoundException;
import java.io.FileReader;

public class Processor {

	public static void main(String[] args) throws FileNotFoundException {
            
		String inputFile = "simpleinput.txt";
		
		FileReader reader = new FileReader(inputFile);
		
		Lexer lexer = new Lexer(reader);
		Parser parser = new Parser(lexer);
		
		try {
			
			System.out.println("Beginning processing...");
			
			Object sym = parser.parse().value;
			
			System.out.println("Finished.");
			
			// This will output the (attribute) value associated with the
			// top-level nonterminal in the parse tree, if there is one
			if (sym != null) {
				System.out.println("Final result: " + sym.toString());
			}
			
		} catch (Exception ex) {
			
			System.out.println(ex.getMessage());	
		}
	}
}
