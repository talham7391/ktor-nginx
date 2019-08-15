package example

import io.ktor.application.Application
import io.ktor.http.HttpMethod
import io.ktor.http.HttpStatusCode
import io.ktor.server.testing.handleRequest
import io.ktor.server.testing.withTestApplication
import kotlin.test.Test
import kotlin.test.assertEquals


class AppTest {
    @Test fun testRoute() = withTestApplication(Application::main) {
        with(handleRequest(HttpMethod.Get, "")) {
            assertEquals(HttpStatusCode.OK, response.status())
        }
    }
}