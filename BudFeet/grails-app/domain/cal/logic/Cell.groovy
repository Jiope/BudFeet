package cal.logic

import java.text.SimpleDateFormat
import java.util.Calendar;
import java.util.ArrayList;
import app.data.Entry;
import app.data.Chronic;

class Cell implements Comparable {
	
	// Size of one cell
	final static int height=90;
	final static int width=160;
	// Position x,y  
	int posX;
	int posY;
	
	float totalAmount;
	
	// Calendar set to cell's date
	Calendar calendar;
	
	int dayOfMonth;	
	String color;
	String date;
	
	ArrayList<Entry> entries = new ArrayList<Entry>();
	ArrayList<Chronic> chronics = new ArrayList<Chronic>();
	
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

	/**
	 * Constructor of class
	 *
	 * @param pCalendar 	: calendar instance set to a particular date
	 * @param pColor 		: color of the cell
	 * @param pTransparency : transparency of the cell
	 * @param x				: position x
	 * @param y				: position y
	 */
	def Cell(Calendar pCalendar, String pColor, int x, int y) {
		
		calendar = pCalendar;
		dayOfMonth 	= pCalendar.get(Calendar.DAY_OF_MONTH);
		date		= sdf.format(pCalendar.getTime());

		color 		= pColor;
		posX 		= x;
		posY 		= y;
	}
		
	/**
	 * Constructor of class
	 *
	 * @param pCalendar 	: calendar instance set to a particular date
	 * @param pColor 		: color of the cell
	 * @param pTransparency : transparency of the cell
	 * @param x				: position x
	 * @param y				: position y
	 */
	def Cell(Calendar pCalendar, String pColor, int x, int y, List<Entry> pEntries, float pTotalAmount) {
		
		calendar = pCalendar;
		dayOfMonth 	= pCalendar.get(Calendar.DAY_OF_MONTH);
		date		= sdf.format(pCalendar.getTime());

		color 		= pColor;
		posX 		= x;
		posY 		= y;
		
		entries = pEntries;
		totalAmount = pTotalAmount;
		
	}
	
	/**
	 * Position cell
	 * 
	 * @param x
	 * @param y
	 */
	def Cell(int x, int y) {
		posX = x;
		posY = y;
	}

	
	/**
	 * ${inherit}
	 */
	@Override
	public int compareTo(Object o) {
		// TODO Auto-generated method stub
		Cell cell = (Cell) o;
		int retval = 0;
		
		if (dayOfMonth > cell.dayOfMonth) {
			retval = 1;
		}
		else if (dayOfMonth < cell.dayOfMonth) {
			retval = -1;
		}
		return retval;
	}
}
