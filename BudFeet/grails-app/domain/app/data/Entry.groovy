package app.data

class Entry {

	// Id
	String username
	// Categorie 
	String categorie
	// Color
	String color
	// Date of Entry
	String date
	// Month_Year of Entry (ie: 11_2015)
	String yearmonth
	// Amount of Entry
	Float amount
	// Wording of Entry
	String wording
	// IN or OUT
	String direction
	
	static constraints = {
		username (nullable: false)
		categorie (nullable: false)
		color (nullable: false)
		date (nullable: false)
		yearmonth (nullable: false)
		amount (nullable: false)
		wording (nullable:true)
		direction (nullable:false)
	}
	
	static mapping = {
		table 'entries'
		username column: 'username'
		categorie column: 'categorie'
		color column: 'color'
		date column: 'date'
		yearmonth column: 'yearmonth'
		amount column: 'amount'
		wording column: 'wording'
		direction column: 'direction'
	}
}
