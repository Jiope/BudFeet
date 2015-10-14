package app.bdd

import app.data.Entry
import app.data.Categorie

class BddInterface {

    static def getUserCategories(String username) {
		def categories = Categorie.executeQuery(
			"from Categorie where username = '" + username + "'")
		return categories
	}
	
	static 	def getMonthEntries(String username, Integer year, Integer monthInYear) {
		def entries = Entry.executeQuery(
			"from Entry where username = '" + username + "' and yearmonth = '" + year + monthInYear + "'")
		return entries
	}
	
	//BddInterface.getUserCategorie(session.name, params.categorie).color
	static def getUserCategorie(String username, String categoriename) {
		def categorie = Categorie.executeQuery(
			"from Categorie where username = '" + username + "' and libelle = '" + categoriename + "'")
		
		return categorie[0]
	}
	
	static def updateCategorieAmount(String username, String categoriename, Float amount) {
		def categorie = Categorie.executeQuery(
			"from Categorie where username = '" + username + "' and libelle = '" + categoriename + "'")
		Float pAmount = amount + categorie[0].amount
		Categorie.executeUpdate(
			"update Categorie set amount = '" + pAmount + "' where username = '" + username + 
			"' and libelle = '" + categoriename + "'")
	}
	
}
