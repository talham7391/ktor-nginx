package example

import io.ktor.application.Application
import io.ktor.application.call
import io.ktor.http.HttpStatusCode
import io.ktor.response.respond
import io.ktor.routing.get
import io.ktor.routing.routing


fun Application.main() {
    routing {
        get {
            call.respond(HttpStatusCode.OK)
        }
    }
}