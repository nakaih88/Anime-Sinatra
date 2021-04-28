require './config/environment'

use Rack::MethodOverride
use UsersController
use AnimeEntriesController
run ApplicationController
