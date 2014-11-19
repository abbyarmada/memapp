class BarcardsController < ApplicationController
 

 def show
    @barcards = Barcard.find :all
 end
 def index
   show
 end
 def list
    show
 end
 def new
    @barcard = Barcard.new
    @peoplebarcard = Peoplebarcard.new
   respond_to do |format|
     format.html  # new.html.erb
     format.xml  { render :xml => @barcard }
   end
 end
 
 def delete 
   destroy
 end

 def destroy
    @pid = params[:pid]
    @barcard = Barcard.find(params[:id])
    @barcard.destroy
    respond_to do |format|
      format.html {redirect_to :back }
      format.xml  { head :ok }
    end
  end

def edit
    @barcard = Barcard.find(params[:id])
  end

def update
    @barcard = Barcard.find(params[:id])
    pid = params[:pid]
    mid = params[:mid]
    respond_to do |format|
      if @barcard.update_attributes(params[:barcard])
        flash[:notice] = 'Barcard was successfully updated.'
        format.html {redirect_to :back }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @barcard.errors, :status => :unprocessable_entity }
      end
    end
 end

 def create
    pid = params[:pid]
    @barcard = Barcard.new(params[:barcard])
    @peoplebarcard = Peoplebarcard.new(params[:peoplebarcard])
    # find the current personbarcard 
    @currentbc = Peoplebarcard.find_by_person_id pid 
    respond_to do |format|
      if @barcard.save
        @peoplebarcard.person_id = pid
        @peoplebarcard.barcard_id = @barcard.id
        @peoplebarcard.save
        if @currentbc 
          @currentbc.destroy
        end
        flash[:notice] = 'Barcard was successfully created.'
        
        format.html {redirect_to  :controller => 'people', :action => 'edit', :id => pid }
        format.xml  { render :xml => @barcard, :status => :created, :location => @barcard }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @barcard.errors, :status => :unprocessable_entity }
      end
    end
  end
end
