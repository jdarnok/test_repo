require 'httparty'
class OverflowClient


  include HTTParty
  base_uri 'api.stackexchange.com'

  def initialize(service, page)
    @options = { query: {site: service, page: page} }
  end

 def get_featured_questions
  Tt self.class.get("/questions/featured", @options)

 end

  def get_no_answer_questions
    response = self.class.get("/questions/no-answers", @options)
    @title = response['items'][1]['title']
  end






  end