package fit.me

import cal.logic.Almanac

import java.text.SimpleDateFormat

import app.data.User
import app.data.Categorie
import cal.constantes.Errors

class LoginController {
	
	static scope = "session";

    def index() {
		render view:"/login";
	}
	
	
	def login() {
		User userExist = User.findWhere(name:params.name)
		User user = User.findWhere(name:params.name, password:params.password)
		if (userExist != null && user != null) {
			session["name"] = user.name
			redirect(controller:"navigation", action:"calendar")
		} else if (user == null && userExist != null) {
			render view:"/login", model:[errorMsg:Errors.LOGIN_ERROR]
		} else {
			render view:"/login", model:[errorMsg:Errors.NO_ACCOUNT_FOUND]
		}
	}
	  
	def logout() {
		session.invalidate()
		render view:"/login", model:[errorMsg:Errors.LOGOUT_SUCCESS]
	}  
	
	def signup() {
		render view:"/register"
	}
	
	def account() {
		
		if (session.name != null) {
			User user = User.findWhere(name:session.name)
			if (user == null) 
				render view:"/login", model:[errorMsg:Errors.SESSION_OVER]
			else
				render view:"/account", model:[user:user]
		} else
			render view:"/login", model:[errorMsg:Errors.MUST_LOGIN]
	}
	  
	def register() {
		  
		User user = new User()
		user.properties = params
		user.birthday = new SimpleDateFormat('dd-MM-yyyy').format(params.birthday)
		user.save()
		
		initUserCategories(user.name)
	  
		return login()
	}
	
	def initUserCategories(String username) {

		Categorie grocery = new Categorie(username, "grocery", "grocery", "green")
		Categorie restaurant = new Categorie(username, "restaurant", "restaurnt", "blue")
		Categorie clothes = new Categorie(username, "clothes", "clothes", "red")
		Categorie amusements = new Categorie(username, "amusements", "amusmts", "orange")
		Categorie miscellaneous = new Categorie(username, "miscellaneous", "misc", "black")
		
		grocery.save()
		restaurant.save()
		clothes.save()
		amusements.save()
		miscellaneous.save()
	}
}