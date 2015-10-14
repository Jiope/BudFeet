package app.data

class Chronic {

	// Id
	String username;
	// Date of value
	String date;
	// Periode of appliance
	String frequency;
	// Amount of Chronic
	Float amount;
	// Wording of Chronic
	String wording;
	// IN or OUT
	String direction;
	
	static constraints = {
		username (nullable: false)
		date (nullable: false)
		frequency (nullable: false)
		amount (nullable: false)
		wording (nullable:true)
		direction (nullable:false)
	}
	
	static mapping = {
		table 'chronics'
		username column: 'username'
		date column: 'date'
		frequency column: 'frequency'
		amount column: 'amount'
		wording column: 'wording'
		direction column: 'direction'
	}
}
