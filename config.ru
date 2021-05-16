require './config/environment'
require './app/controllers/application_controller.rb'

# HTML Forms only support GET and POST requests. To perform other actions such as PUT, PATCH or DELETE, use the Rack::MethodOverride middleware.
# -https://tynn.readthedocs.io/en/latest/guides/method_override/
# Invoke middleware
use Rack::MethodOverride
use SessionController
use AccountController
use ProductController
# Run application
run ApplicationController

