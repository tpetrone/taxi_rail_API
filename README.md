##########################################################################################
#############################################
#############################################
##########################################################################################
#############################################
#############################################
##########################################################################################
Getting_started:
*	$ rails new taxi
*	$ cd taxi

#############################################

Dependencies:
>	$ echo "gem 'devise'" >> Gemfile
>	$ echo "gem 'omniauth'" >> Gemfile
>	$ bundle install
>	$ rails generate devise:install

#############################################

Models:

rails g devise User
rails g devise:views 
rails g migration add_meta_to_users meta_id:integer meta_type
rails g scaffold Client name phone lat:float lng:float
rails g scaffold Driver name phone car_model lat:float lng:float
rails g model Corrida client_id:integer driver_id:integer address
rails g controller Corridas create update
rails g controller welcome index
rake db:migrate

#############################################
#############################################
Migration
# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140818105408) do

  create_table "clients", force: true do |t|
    t.string   "name"
    t.integer  "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drivers", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "car_model"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meta_id"
    t.string   "meta_type"

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["meta_id", "meta_type"], name: "index_users_on_meta_id_and_meta_type"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

#################
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
belongs_to :meta, polymorphic: true 
  
end

###########################################3
class Client < ActiveRecord::Base
  has_one :user, as: :meta, dependent: :destroy
  accepts_nested_attributes_for :user
  
  validates :name, presence: true
  validates :phone, presence: true

end

##########################################
class Driver < ActiveRecord::Base
  has_one :user, as: :meta, dependent: :destroy
  accepts_nested_attributes_for :user
  
  validates :name, presence: true
  validates :phone, presence: true
validates :car_model presence: true
end

##########################################
Controllers:
#######################################
/app/controllers/clients_controller.rb

class ClientsController < ApplicationController
  
  #devise stuff
  before_action :authenticate_user!, :authenticate_client, except: [:new, :create, :update, :show]
  before_action :new_registration, only: [:new, :create]
  before_action :set_client, only: [:show, :edit, :update, :destroy]

//auto-generates

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

#######################################
/app/controllers/drivers_controller.rb

class DriversController < ApplicationController
  
  #devise stuff
  before_action :authenticate_user!, :authenticate_driver, except: [:new, :create, :update, :show]
  before_action :new_registration, only: [:new, :create]
  before_action :set_driver, only: [:show, :edit, :update, :destroy]

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

###################################################
Routes:

  
  devise_for :users, :skip => [:registrations]
  resources :clients
  resources :drivers
  root 'welcome#index'

#############################

Dúvidas:
/config/initializers/devise.rb (Scopes configuration)
