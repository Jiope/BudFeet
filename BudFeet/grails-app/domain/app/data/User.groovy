package app.data


class User {
	
	//static hasMany = [categories: Categorie]
	String name
	String password
	String birthday
	String email
	
    static constraints = {
		name (unique: true)
		password (password: true)
		birthday (nullable:false)
		email (nullable:false)
    }
	
	static mapping = {
		table 'users'
		name column: 'name'
		password column: 'password'
		birthday column: 'birthday'
		email column: 'email'
	}
	
	public User() {
		
	}
	
	public User(User pUser) {
		name = pUser.name;
		password = pUser.password;
		birthday = pUser.birthday;
		email = pUser.email;
	}
}
