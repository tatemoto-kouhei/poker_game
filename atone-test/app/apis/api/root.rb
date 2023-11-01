require 'grape'

module API
  class Root < Grape::API
    prefix 'api'
    mount API::Ver1::Poker

    format :json

    # get do


    # end
  end
end

