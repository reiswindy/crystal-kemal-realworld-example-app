require "./env"
require "./realworld/models/*"
require "./realworld/services/*"
require "./realworld/handlers/*"
require "./realworld/version"
require "./realworld/errors"
require "./realworld/routes"

require "kemal"

add_context_storage_type(Realworld::Models::User?)

add_handler(Realworld::Handlers::AuthRequiredHandler.new)
add_handler(Realworld::Handlers::AuthOptionalHandler.new)

error 401 {|env| ""}
error 403 {|env| ""}
error 404 {|env| ""}
error 422 {|env, exception| exception.as(Realworld::UnprocessableEntityException).content}

before_all {|env| env.response.content_type = "application/json"}
before_all {|env| env.response.headers["Access-Control-Allow-Origin"] = "*"}

Kemal.run
