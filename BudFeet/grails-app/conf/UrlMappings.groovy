class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/login")
        "500"(view:'/error')
		
		"/**.gsp" {
			 controller = {
				 if(request.requestURL.toString().endsWith(".gsp")) {
					 "forbidden"
				 } else params.controller
			 }
		 }
	}
}
