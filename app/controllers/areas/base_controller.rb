class Areas::BaseController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_area, only: [:show, :documentos_esperando, :documentos_recibir, :documentos_recibidos, :recibir_documento]
  def index
  	@areas = current_user.areas
  end

  def show
  	
  end

  def recibir_documento
    @movimiento = Docmovimiento.find(params[:docmovimiento_id])
    if @area.id == @movimiento.area_destino_id
      @movimiento.recibido = true
    end

    respond_to do |format|
      if @movimiento.save
        format.json{ render json: @movimiento}
      end
    end
  end

  def documentos_esperando
    @items = @area.movimientos_fuente.where(recibido: false)
    respond_to do |format|
      format.json{ render json: @items.to_json(:include => [:documento]) }
    end
  end

  def documentos_recibir
    @items = @area.movimientos_destino.where(recibido: false)
    respond_to do |format|
      format.json{ render json: @items.to_json(:include => [:documento]) }
    end
  end

  def documentos_recibidos
    @items = @area.movimientos_destino.where(recibido: true)
    respond_to do |format|
      format.json{ render json: @items.to_json(:include => [:documento]) }
    end
  end

  private
    def set_area
    	@area = Area.find(params[:id])
    end

end
