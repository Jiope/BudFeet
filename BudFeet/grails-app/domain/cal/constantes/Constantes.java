package cal.constantes;

import java.util.Random;


public class Constantes {

	public final static String[] CSS_CLASS_COLOR_GREEN = {"#FFFFFF", "#CCFFCC", "#99FF99", "#19FF19"};
	public final static String[] CSS_CLASS_COLOR_BLUE = {"#FFFFFF", "#CCCCFF", "#9999FF", "#1919FF"};

	public final static int svgMY1 = 20;
	public final static int svgMY2 = 24;
	public final static int svgMY3 = 60;
	public final static int svgMY4 = 80;
	public final static int svgMY5 = 35;
	
	
	public final static int svgMX1 = 10;
	public final static int svgMX2 = 80;
	public final static int svgMX3 = 155;
	
	public Constantes() {
		
	}
	
	public static String getRandomColor() {
		Random rand = new Random();
		return Constantes.CSS_CLASS_COLOR_GREEN[rand.nextInt(4)];
	}
}
