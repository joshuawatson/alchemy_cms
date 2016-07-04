# Use this module to easily test Alchemy actions within Alchemy components
# or inside your application to test routes for the mounted Alchemy engine.
#
# Inside your spec_helper.rb, include this module inside the RSpec.configure
# block by doing this:
#
#   require 'alchemy/test_support/controller_requests'
#   RSpec.configure do |c|
#     c.include Alchemy::TestSupport::ControllerRequests, type: :controller
#   end
#
# Then, in your controller tests, you can access alchemy routes like this:
#
#   require 'spec_helper'
#
#   describe Alchemy::Admin::PagesController do
#     it "can see all the pages" do
#       alchemy_get :index
#     end
#   end
#
# Use alchemy_get, alchemy_post, alchemy_put or alchemy_delete to make requests
# to the Alchemy engine, and use regular get, post, put or delete to make
# requests to your application.
#
# Note: Based on Spree::TestingSupport::ControllerRequests. Thanks <3
#
module Alchemy
  module TestSupport
    module ControllerRequests
      extend ActiveSupport::Concern

      # Executes a request simulating GET HTTP method
      def alchemy_get(action, parameters = nil, session = nil, flash = nil)
        process_alchemy_action action,
          params: parameters,
          session: session,
          flash: flash,
          method: 'GET'
      end

      # Executes a request simulating POST HTTP method
      def alchemy_post(action, parameters = nil, session = nil, flash = nil)
        process_alchemy_action action,
          params: parameters,
          session: session,
          flash: flash,
          method: 'POST'
      end

      # Executes a request simulating PUT HTTP method
      def alchemy_put(action, parameters = nil, session = nil, flash = nil)
        process_alchemy_action action,
          params: parameters,
          session: session,
          flash: flash,
          method: 'PUT'
      end

      # Executes a request simulating DELETE HTTP method
      def alchemy_delete(action, parameters = nil, session = nil, flash = nil)
        process_alchemy_action action,
          params: parameters,
          session: session,
          flash: flash,
          method: 'DELETE'
      end

      # Executes a simulated XHR request
      def alchemy_xhr(method, action, parameters = nil, session = nil, flash = nil)
        process_alchemy_action action,
          params: parameters,
          session: session,
          flash: flash,
          method: method,
          xhr: true
      end

      private

      def process_alchemy_action(action, options = {})
        @routes = Alchemy::Engine.routes
        process(action, options)
      end
    end
  end
end
