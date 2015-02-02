class ClientsController < ApplicationController
  
  #devise stuff
  before_action :authenticate_user!, :authenticate_client, except: [:new, :create, :update, :show]
  before_action :new_registration, only: [:new, :create]
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @clients = Corrida.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
    @client.build_user
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Callbacks:
    
    #Find
    def set_client
      @client = Client.find(params[:id])
    end

    # Strong parameters
    def client_params
      params.require(:client).permit(:name, :phone, user_attributes: [ :id, :email, :password, :password_confirmation ])
    end
    
    def authenticate_client     
      redirect_to(new_user_session_path) unless current_user.meta_type == "Client"  
    end
    
    def new_registration
      redirect_to(clients_path) if user_signed_in?
    end
end
