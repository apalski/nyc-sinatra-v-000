
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
		# @title = Title.all
		# @landmark = Landmark.all
		erb :'figures/show'
	end

	post '/figures' do
	    @figure = Figure.create(params[:figure])
	    @figure.titles << Title.find_or_create_by(name: params[:title][:name])
	    if !params[:landmark][:name].empty?
	      @figure.landmarks << Landmark.create(params[:landmark])
	    end
	    @figure.save
	    redirect "/figures/#{@figure.id}"
  	end

	get '/figures/:id/edit' do
		@figure = Figure.find_by_id(params[:id])
		@title = Title.all
		@landmark = Landmark.all
		erb :'figures/edit'
	end

	post '/figures/:id' do
	    @figure = Figure.find_by_id(params[:id])
	    @figure.update(params[:figure])
	    @figure.titles << Title.find_or_create_by(name: params[:title][:name])
	    @figure.landmarks << Landmark.find_or_create_by(name: params[:landmark][:name])
	    @figure.save
    	redirect "/figures/#{@figure.id}"
  	end
end




