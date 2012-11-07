class ContactsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorized_user, :only => [:show, :destroy, :edit, :update]

  # GET /contacts
  def index
    @user = current_user
    @contacts = @user.contacts
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end

  # GET /contacts/1
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  def new
    @contact = Contact.new if signed_in?
    unless params[:id].nil?
      @contact = Contact.find(params[:id])
      @contact.user_id = current_user
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # POST /contacts
  def create
    @contact = current_user.contacts.build(params[:contact])
    respond_to do |format|
      if @contact.save
        format.html { redirect_to(@contact, :notice => 'Contact was successfully created.') }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /contacts/1/edit
  def edit
  end

  # PUT /contacts/1
  def update
    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to(@contact, :notice => 'Contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end

  # Prevent users from viewing/modifying other user's contacts if id is known.
  def authorized_user
    if current_user.try(:admin?) #if admin they are allowed to modify any user's contact
      @contact = Contact.find(params[:id])
    else
      @contact = current_user.contacts.find_by_id(params[:id])
    end
    redirect_to contacts_path if @contact.nil?
  end
end
