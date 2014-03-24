class PeoplebarcardsController < ApplicationController
 

  def show
    @barcards = Peoplebarcard.find :all
      
    respond_to do |format|    
      format.html # 
     # format.xml  { render :xml => @barcards }
    end
  end
 def index
   show
 end
  def list
    show
 end
 
   def new
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
    
    @peoplebarcard = Peoplebarcard.find(params[:id])
    
    @peoplebarcard.destroy
    
    respond_to do |format|
      format.html {redirect_to :back }
      format.xml  { head :ok }
    end
  end

def edit
    @peoplebarcard = Peoplebarcard.find(params[:id])
  end

def update
   pid = params[:pid]
   
    @peoplebarcard = Peoplebarcard.find(params[:id])
    mid = params[:mid]

    respond_to do |format|
      if @peoplebarcard.update_attributes(params[:peoplebarcard])
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
    @peoplebarcard = Peoplebarcard.new(params[:barcard])
   
    respond_to do |format|
      if @barcard.save
        flash[:notice] = 'Barcard was successfully created.'
        format.html {redirect_to  :controller => 'people', :action => 'edit', :id => @barcard.person_id }
        format.xml  { render :xml => @barcard, :status => :created, :location => @barcard }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @barcard.errors, :status => :unprocessable_entity }
      end
    end
  end

def expired
  
     @expiredmems = Member.expired_members
      
    respond_to do |format|    
      format.html # 
     # format.xml  { render :xml => @barcards }
    end


end


end

