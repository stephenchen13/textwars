# app.rb

require 'sinatra'

get '/' do
  erb :index
end

post '/' do
  # TODO: Read the message contents, save to the database
  @wait_time = AlgorithmHelper.calculate_wait(params[:she_likes_me], params[:you_like_her],
  	params[:your_rank], params[:her_rank], params[:her_response_time], 
  	params[:your_response_time], params[:your_text_count], params[:her_text_count])
  @wait_time = params[:she_likes_me]
  erb :result
end

class AlgorithmHelper
	class << self
		@@lookup_table = {
			14 =>	2, 17 =>	1.9, 20 =>	1.85, 25 =>	1.8, 29 =>	1.75, 33 =>	1.7, 40 =>	1.65, 43 =>	1.6, 50 =>	1.55, 
			57 =>	1.5, 60 =>	1.45, 67 =>	1.4, 71 =>	1.35, 75 =>	1.3, 80 =>	1.25, 83 =>	1.2, 86 =>	1.1, 100 =>	1, 
			117 =>	0.9,120 =>	0.85, 125 =>	0.8, 133 =>	0.75, 140 =>	0.7, 150 =>	0.65, 167 =>	0.6, 175 =>	0.55,
			200 =>	0.5, 233 =>	0.45, 250 =>	0.4, 300 =>	0.35, 350 =>	0.3, 400 =>	0.25, 500 =>	0.2, 600 =>	0.15,
			700 =>	0.1
		}

		def calculate_wait(she_likes_me, you_like_her, your_rank, her_rank, her_response_time, your_response_time, your_text_count, her_text_count) 
			(her_response_time.to_f * add_multipliers(she_likes_me, you_like_her, your_rank, her_rank) *
			response_time_ratio(your_response_time, her_response_time) *
			total_number_ratio(your_text_count, her_text_count)).round
		end

		def add_multipliers(she_likes_me, you_like_her, your_rank, her_rank)
			@@lookup_table[(she_likes_me.to_f / you_like_her.to_f * 100).round] * 0.65 + @@lookup_table[(your_rank.to_f / her_rank.to_f * 100).round] * 0.35
		end

		def response_time_ratio(your_response_time, her_response_time)
			1 + (your_response_time.to_i == 0 ? 0 : (her_response_time.to_f - your_response_time.to_f) / your_response_time.to_f / 2)
		end

		def total_number_ratio(your_text_count, her_text_count)
			return your_text_count.to_i * 3 if her_text_count.to_i == 0
			1 + (your_text_count.to_i + her_text_count.to_i > 8 ? ((your_text_count.to_i - her_text_count.to_i) / her_text_count.to_f) / 2 : 0)
		end

	end
end