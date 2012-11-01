class PostsController < ApplicationController
	def new
		@post = Post.new
	end

	def create
		#only one render allowed
		#render text: params[:post].inspect
		#render text: params[:post].sort[0].inspect
		#render text: params[:post].count.inspect
		#render text: params[:post].keys.inspect
		#render text: params[:post].values.inspect

		@post = Post.new(params[:post])
 		
 		if @post.save
    		redirect_to action: :show, id: @post.id
  		else
    		render 'new'
  		end

  	end

  	def show
  		@post = Post.find(params[:id])
	end

	def index

  		#@posts = Post.all

			

  		if params[:search]
	      @posts = Post.find(:all, :conditions => ["title LIKE ? or text LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%" ])
	     #flash.now[:success] =  @posts.first.comments.first.commenter

	      coll = @posts.first.comments
	     
	     message = ""
	     coll.each do |c|
  			message = message +   "#{c.inspect}" 
		 end
		 	flash.now[:success] = message

	    else
	      @posts = Post.find(:all)
	    end
	 

	end


	def edit
		@post = Post.find(params[:id])
	end


	def update
  		 @post = Post.find(params[:id])
 
		  if @post.update_attributes(params[:post])
		    redirect_to action: :show, id: @post.id
		  else
		    render 'edit'
		  end
	end

	def destroy
  		@post = Post.find(params[:id])
  		@post.destroy
 
  		redirect_to action: :index
	end
=begin
	def search
	   	    
	    if params[:search]
	      @posts = Post.find(:all, :conditions => ["text LIKE ?", "%#{params[:search]}%"])
	    else
	      @posts = Post.find(:all)
	    end
	 
	   
  	end


	def search
    	query = params[:q]
    	@posts = Post.find(:all, :conditions => ["title = ?", query])
  	end
=end
end
