class DriversController < ApplicationController
  
  #devise stuff
  before_action :authenticate_user!, :authenticate_driver, except: [:new, :create, :update, :show]
  before_action :new_registration, only: [:new, :create]
  before_action :set_driver, only: [:show, :edit, :update, :destroy]

  # GET /drivers
  # GET /drivers.json
  def index
	@drivers = Corrida.all
	

    
  end

  # GET /drivers/1
  # GET /drivers/1.json
  def show
  end

  # GET /drivers/new
  def new
    @driver = Driver.new
    @driver.build_user
  end

  # GET /drivers/1/edit
  def edit
  end

  # POST /drivers
  # POST /drivers.json
  def create
    @driver = Driver.new(driver_params)

    respond_to do |format|
      if @driver.save
        format.html { redirect_to @driver, notice: 'Driver was successfully created.' }
        format.json { render :show, status: :created, location: @driver }
      else
        format.html { render :new }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drivers/1
  # PATCH/PUT /drivers/1.json
  def update
    respond_to do |format|
      if @driver.update(driver_params)
        format.html { redirect_to @driver, notice: 'Driver was successfully updated.' }
        format.json { render :show, status: :ok, location: @driver }
      else
        format.html { render :edit }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drivers/1
  # DELETE /drivers/1.json
  def destroy
    @driver.destroy
    respond_to do |format|
      format.html { redirect_to drivers_url, notice: 'Driver was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Callbacks:
    
    #Find
    def set_driver
      @driver = Driver.find(params[:id])
    end

    # Strong parameters
    def driver_params
      params.require(:driver).permit(:name, :phone, :car_model, user_attributes: [ :id, :email, :password, :password_confirmation ])
    end
    
    def authenticate_driver     
      redirect_to(new_user_session_path) unless current_user.meta_type == "Driver"  
    end
    
    def new_registration
      redirect_to(drivers_path) if user_signed_in?
    end
end
