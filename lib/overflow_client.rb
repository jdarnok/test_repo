require 'httparty'
class OverflowClient


  include HTTParty
  base_uri 'api.stackexchange.com'

  def initialize(page,service="stackoverflow")
    @options = { query: {site: service, page: page} }
  end

 def get_featured_questions
   self.class.get("/questions/featured", @options)

 end

  def get_featured_questions_owners
    response =  self.class.get("/questions/featured", @options)
    array = []
    response['items'].each do |item|

      array << item['owner']

    end

    array
  end

  def get_featured_questions_tags
    response =  self.class.get("/questions/featured", @options)
    array = []
    response['items'].each do |item|

      array << item['tags']

    end
    array
  end

  def get_no_answer_questions
    response = self.class.get("/questions/no-answers", @options)
    @title = response['items'][1]['title']
  end

  def get_unanswered_questions
    response = self.class.get("/questions/unanswered", @options)
    @title = response['items'][1]['title']
  end






  end