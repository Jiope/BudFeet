package cal.logic


import java.awt.Point
import java.text.SimpleDateFormat
import java.util.ArrayList
import java.util.Calendar
import java.util.Random

import app.data.User
import app.data.Entry
import app.data.Categorie
import app.bdd.BddInterface

import cal.constantes.Constantes
import fit.me.NavigationController
import grails.converters.JSON

class Almanac {

	String userName
	ArrayList<Month> listMonth = new ArrayList<Month>()
	ArrayList<Categorie> categories = new ArrayList<Categorie>()
	
    static constraints = {
    }
	
	def Almanac(String pUserName) {
		userName = pUserName
    }
	
	// faire les calculs coté serveur pour ne les faire qu'une fois par jour	
	def populate() {
	
		Calendar calendar = Calendar.getInstance();
		Month month;
		
		categories = BddInterface.getUserCategories(userName)

		int offset = 0	
		//calendar.add(Calendar.MONTH, -1);
		
		//for (int index = calendar.get(Calendar.MONTH); index < calendar.get(Calendar.MONTH)+1; index++) {
			
			month = new Month(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH))
			month.populate(userName)
			
			//offset += getOffset(calendar.get(Calendar.MONTH))
			
			listMonth.add(month)
			calendar.add(Calendar.MONTH, 1)
		//}
		
	}
	
	def getMonth(int monthInYear, int year, String direction) {
		Month month;
		
		if (direction == 'left') {
			if (monthInYear == 0)
				month = new Month(year-1, 11);//, -getOffset(11, year-1))
			else
				month = new Month(year, monthInYear-1);//, -getOffset(monthInYear-1, year))
		}
		else {
			if (monthInYear == 11)
				month = new Month(year+1, 0);//, getOffset(0, year+1))
			else
				month = new Month(year, monthInYear+1);//, getOffset(monthInYear+1, year))
		}
		month.populate(userName)
		return month
	}
	
	def getOffset(int month, year) {
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
		
		return offset+2;
		
	}
	
	
}
