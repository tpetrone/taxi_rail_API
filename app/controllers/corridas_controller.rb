class CorridasController < ApplicationController

  def create
	@corrida = Corrida.new(corrida_params)
	@corrida.save	
	redirect_to action: "show", id: @corrida.id
  end

	def show
	@corrida = Corrida.find params[:id]
	end

  def update
	@corrida = Corrida.find params[:id]
	@corrida.update(corrida_params)
  end
  
    def destroy
    @corrida = Corrida.find params[:id]
    @corrida.destroy
    redirect_to drivers_url, notice: 'Client was successfully destroyed.'
  end
  
  def reload
	@corrida = Corrida.find params[:id]
	render :partial => 'dynamic', :object => @corrida
  end
  
  def corrida_params
      params.permit(:id, :client_id, :driver_id, :address)
    end
  
end
