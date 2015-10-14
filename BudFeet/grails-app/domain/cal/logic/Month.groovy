package cal.logic

import java.awt.Point
import java.text.SimpleDateFormat
import java.util.ArrayList
import app.data.Entry
import app.data.Chronic
import app.bdd.BddInterface

import cal.constantes.Constantes;

public class Month {
	
	ArrayList<Cell> days;
	
	int year;
	
	int monthInYear;
	int monthOffset;
	int previousMonthOffset;
	int nextMonthOffset;
	int monthSize;
	String monthBorder;
	
	String monthName;
	Integer[] nameLeft = new Integer[2];
	Integer[] nameRight = new Integer[2];
	
	public Month(int pYear, int month) {
		monthInYear = month;
		days = new ArrayList<Cell>();
		year = pYear;
	}
	
	def getMonthChronics(int userID) {
		List<Chronic> chronics = new ArrayList<Chronic>();
		
		return chronics;
	}
	
	def populate(String userName) {
		
		StringBuilder monthBorderBuilder = new StringBuilder();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
		
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, year);
		calendar.set(Calendar.MONTH, monthInYear);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		
		monthName = calendar.getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.ENGLISH);
		monthSize = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		int month = calendar.get(Calendar.MONTH);
		int year = calendar.get(Calendar.YEAR);
		
/*		if (month == 0)
			previousMonthOffset = getOffset(11, year-1);
		else if (month == 11)
			nextMonthOffset = getOffset(0, year+1);
		else {
			previousMonthOffset = getOffset(month-1, year);
			nextMonthOffset = getOffset(month+1, year);
		}*/
		
		List<Entry> entries = BddInterface.getMonthEntries(userName, year, monthInYear)
		
		int firstDay = calendar.get(Calendar.DAY_OF_WEEK);
		int x = 0;
		int y = 0;
		// Decalage en pixel de tous les elements
		int x_0 = 0;
		int y_0 = 50;
		
		int week = 0;
		
		int trueDay = 0;
		int trueWeek = 0;
		String[] borderPoints = new String[10];
		
		for (int index = 0; index < calendar.getActualMaximum(Calendar.DAY_OF_MONTH); index++) {
			
			if (calendar.get(Calendar.DAY_OF_MONTH) == 1) {
				if (calendar.get(Calendar.WEEK_OF_MONTH) == 0) 
					trueWeek = 0;
				else trueWeek = 1;
			}
				
			if (calendar.get(Calendar.DAY_OF_WEEK) == 1) 
				trueDay = 8;
			else
				trueDay = calendar.get(Calendar.DAY_OF_WEEK);
			
			x = x_0 + (calendar.get(Calendar.WEEK_OF_MONTH)-trueWeek)*Cell.width + 60; //+ monthOffset*Cell.width;
			y = y_0 + (trueDay-2)*Cell.height;
			
			Cell cell;
			// /!\ CODE DEGEU A REFAIRE OMG 
			if (entries != null) {
				List<Entry> ent = getEntriesOfDay(entries, sdf.format(calendar.getTime()))
				cell = new Cell(calendar, "#fff", x, y, ent, getTotalAmount(ent));
			}
			else cell = new Cell(calendar, "#fff", x, y);
			
			days.add(cell);
			setMonthBorder(calendar, x, y, borderPoints);
			
			if (index != calendar.getActualMaximum(Calendar.DAY_OF_MONTH)-1)
				calendar.add(Calendar.DATE, 1);
		}
		monthBorder = concatStringList(borderPoints);
	}
	
	def getEntriesOfDay(List<Entry> entries, String date) {
		
		List<Entry> dayEntries = new ArrayList<Entry>();
		for (Entry e : entries) {
			if (date.equals(e.date)) {
				dayEntries.add(e)
			}
		}
		return dayEntries;
	}
	
	def getTotalAmount(List<Entry> dayEntries) {
		float totalAmount = 0
		
		for (Entry e : dayEntries) {
			if (e.amount != null)
				totalAmount += e.amount
		}
		return totalAmount
	}
	
	def setMonthBorder(Calendar calendar, int x, int y, String[] borderPoints) {
		
		if ( (calendar.get(Calendar.DAY_OF_MONTH) == 1) ) {
			int posY = y + Cell.height;
			int posX = x + Cell.width;
			
			borderPoints[0] = x + "," + posY + " ";
			borderPoints[1] = x + "," + y + " ";
			borderPoints[2] = posX + "," + y + " ";
		}
		
		// premier lundi 		: x		, y
		if ( (calendar.get(Calendar.DAY_OF_MONTH) < 8) && (calendar.get(Calendar.DAY_OF_WEEK) == 2) ) {
			borderPoints[3] = x + "," + y + " ";
			nameLeft[0] = x
			nameLeft[1] = y
		}
		// dernier lundi 		: x+size, y
		if ( (calendar.get(Calendar.DAY_OF_MONTH) > monthSize - 7) && (calendar.get(Calendar.DAY_OF_WEEK) == 2) ) {
			int posX = x + Cell.width;
			borderPoints[4] = posX + "," + y + " ";
			nameRight[0] = posX
			nameRight[1] = y
		}
		// dernier jour du mois : x+size, y+size && x, y+size
		if (calendar.get(Calendar.DAY_OF_MONTH) == monthSize) {
			int posX = x + Cell.width;
			int posY = y + Cell.height;
			borderPoints[5] = posX + "," + posY + " ";
			borderPoints[6] = x + "," + posY + " ";
		}
		// dernier dimanche		: x+size, y+size
		if ( (calendar.get(Calendar.DAY_OF_MONTH) > monthSize - 7) && (calendar.get(Calendar.DAY_OF_WEEK) == 1) ) {
			int posX = x + Cell.width;
			int posY = y + Cell.height;
			borderPoints[7] = posX + "," + posY + " ";
		}
		// premier dimanche		: x		, y+size
		if ( (calendar.get(Calendar.DAY_OF_MONTH) < 8) && (calendar.get(Calendar.DAY_OF_WEEK) == 1) ) {
			int posY = y + Cell.height;
			borderPoints[8] = x + "," + posY + " ";
		}
		
	}
	
	def getOffset(int month, int year) {
		int offset = 0;
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, year);
		calendar.set(Calendar.MONTH, month);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		int thismonth = calendar.get(Calendar.MONTH);
		while (calendar.get(Calendar.MONTH) == thismonth) {
		
			String newstring = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
			
			if (calendar.get(Calendar.DAY_OF_WEEK) == 2)
				offset++;
			if (calendar.get(Calendar.DAY_OF_MONTH) == 1 && calendar.get(Calendar.DAY_OF_WEEK) != 2)
				offset++;
			
			calendar.add(Calendar.DATE, 1);
		}
		
		return offset;
		
	}
	
	def concatStringList(String[] stringList) {
		
		StringBuilder concatString = new StringBuilder();
		
		for (String string : stringList) {
			if (string != null)
			concatString.append(string);
		}
		
		return concatString;
	}
	
}
