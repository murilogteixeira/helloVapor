import Vapor

struct LoginRequest: Content {
    let email: String
    let senha: String
}

struct User: Content {
    let nome: String
    let email: String
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("murilo") { req in
        return "Murilo"
    }
    
    router.post("login") { req -> Future<HTTPStatus> in
        return try req.content.decode(LoginRequest.self).map(to: HTTPStatus.self) { loginRequest in
            print(loginRequest.email)
            print(loginRequest.senha)
            return .ok
        }
    }
    
    router.get("user") { req -> User in
        return User(
            nome: "Murilo Teixeira",
            email: "murilo@murilo.com"
        )
    }
    
    router.get("img") { req -> Response in
        return req.redirect(to: "/img.png")
    }
    
//    router.get("site") { req in
//        return req.redirect(to: "/site/index.html")
//    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
