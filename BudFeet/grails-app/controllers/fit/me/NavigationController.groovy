package fit.me

import cal.logic.Almanac
import cal.logic.Month
import cal.logic.Cell
import cal.constantes.Errors
import app.data.Entry
import app.data.User
import app.data.Categorie
import app.bdd.BddInterface

import grails.converters.JSON
import java.text.SimpleDateFormat
import java.util.ArrayList;

class NavigationController {
	
    def index() { }
	
	def calendar() {
		
		if (session.name != null) {
			Almanac almanac = new Almanac(session.name)
			almanac.populate()
			render view:"/calendar", model:[almanac:almanac]
		} else {
			render view:"/login", model:[errorMsg:Errors.MUST_LOGIN]
		} 
	}
	
	def createEntry() {
		
		if (session.name != null) {
		
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
			Calendar cal = Calendar.getInstance()
			cal.setTime(sdf.parse(params.date))
			
			Entry entry = new Entry()
			entry.date = params.date
			entry.yearmonth = cal.get(Calendar.YEAR).toString() + cal.get(Calendar.MONTH).toString()
			entry.categorie = params.categorie
			entry.color = BddInterface.getUserCategorie(session.name, params.categorie).color
			entry.amount = Float.parseFloat(params.amount).round(2)
			entry.username = session.name
			entry.wording = params.infos
			entry.direction = "OUT"
			
			BddInterface.updateCategorieAmount(session.name, params.categorie, entry.amount)
			
			if (entry.save())
				render 'Entry saved : ' + entry.categorie + ' | ' + entry.amount
			else 
				render 'Fail to save Entry : ' + entry.categorie + ' | ' + entry.amount
		}
		else
			render view:"/login", model:[errorMsg:Errors.MUST_LOGIN]
	}
	
	def updateEntry() {
		
	}
	
	def deleteEntry() {
		
	}
	
	def loadMonth() {
		if (session.name != null) {
			Almanac almanac = new Almanac(session.name)
			Month month = almanac.getMonth(Integer.valueOf(params.monthInYear), Integer.valueOf(params.year), params.direction)
			render month as JSON
		} else {
			render view:"/login", model:[errorMsg:Errors.MUST_LOGIN]
		}
	}
	
	def createCategorie() {
		
		if (session.name != null) {
			if (checkCategorie()) {
				Categorie categorie = new Categorie()
				categorie.username = session.name
				categorie.libelle = params.libelle
				if (params.shortlibelle == "")
					categorie.shortlibelle = params.libelle
				else categorie.shortlibelle = params.shortlibelle
				categorie.color = params.color
				categorie.amount = 0.0
				
				if (categorie.save())
					render 'Categorie saved : ' + categorie.libelle
				else 
					render 'Fail to save Categorie : ' + categorie.libelle
			}
		}
		else
			render view:"/login", model:[errorMsg:Errors.MUST_LOGIN]
	}
	
	// Unused
	def getMonthOffset() {
		int retMonthNbr = 0;
		if (params.direction.equals("left"))
			retMonthNbr = Integer.parseInt(params.monthInYear) - 1;
		else
			retMonthNbr = Integer.parseInt(params.monthInYear) + 1;
			
		Month m = new Month();
		
		int x0 = Integer.parseInt(params.x0);
		int monthoffset = m.getOffset(retMonthNbr, Integer.parseInt(params.year))+1;
		int offset = (m.getOffset(retMonthNbr, Integer.parseInt(params.year))+1)*Cell.width + Integer.parseInt(params.x0);
		render offset;
	}
	
	def checkCategorie() {
		ArrayList<Categorie> categories = new ArrayList<Categorie>()
		categories = BddInterface.getUserCategories(session.name)
		boolean retval = true;
		for (Categorie cat : categories) {
			if (cat.libelle.contains(params.libelle)) 
				retval = false;
		}
		return retval;
	}
	
	def settings() {
		render view:"/settings"
	}
}
