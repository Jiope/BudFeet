package app.data

class Categorie {

	// Id
	String username
	String libelle
	String shortlibelle
	String color
	Float amount
	
	static constraints = {
		username (nullable: false)
		libelle (nullable: false)
		shortlibelle (nullable: false)
		color (nullable:false)
		amount (nullable:false)
	}
	
	static mapping = {
		table 'categories'
		username column: 'username'
		libelle column: 'libelle'
		shortlibelle column: 'shortlibelle'
		color column: 'color'
		amount column: 'amount'
	}
	
	def Categorie(String pUsername, String pLibelle, String pColor) {
		username = pUsername
		libelle = pLibelle
		color = pColor
		amount = 0
	}
	
	def Categorie(String pUsername, String pLibelle, String pShortlibelle, String pColor) {
		username = pUsername
		libelle = pLibelle
		shortlibelle = pShortlibelle
		color = pColor
		amount = 0
	}
}
