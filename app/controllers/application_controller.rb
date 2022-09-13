class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  include JsonapiErrorsHandler
  ErrorMapper.map_errors!(
      'ActiveRecord::RecordNotFound' => 
      'JsonapiErrorsHandler::Errors::NotFound'
  )
  rescue_from ::StandardError, with: lambda { |e| handle_error(e) }
end
