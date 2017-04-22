
class FiguresController < ApplicationController


	get '/figures' do
		@figure = Figure.all
		erb :'figures/index'
	end	

	get '/figures/new' do
		@title = Title.all
		@landmark = Landmark.all
		erb :'figures/new'
	end

	get '/figures/:id' do
		@figure = Figure.find_by_id(params[:id])
		erb :'figures/show'
	end

	post '/figures' do
		puts params
		@figure = Figure.create(name: params[:figure[name]])
		params[:figure[:title_ids]].each do |titles|
			@figure.title_ids << titles
		end
		params[:figure[landmark_ids]].each do |landmarks|
			@figure.landmark_ids << landmarks
		end	
		if !Title.find_by(name: params[:title[name]])
			@figure.titles << Title.create(name: params[:title[name]])
		end	
		if !Landmark.find_by(name: params[:landmark[name]])
			@figure.landmarks << Landmark.create(name: params[:landmark[name]])
		end	
		@figure.save	
		redirect "/figures/#{@figure.id}"
	end	
end