class PagesController < ApplicationController
  
  before_filter :authenticate_admin!, :only => [ :admin ]
  
end