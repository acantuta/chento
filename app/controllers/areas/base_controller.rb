class Areas::BaseController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_area, only: [:show, :documentos_esperando, :documentos_recibir, :documentos_recibidos, :recibir_documento, :cambiar_estado_documento, :documentos_enviados, :documentos_todos]
  def index
  	@areas = current_user.areas
    redirect_to areas_base_url(@areas.first.id) if @areas.count==1
  end

  def show
  	
  end

  def recibir_documento
    @movimiento = Docmovimiento.find(params[:docmovimiento_id])
    if @area.id == @movimiento.area_destino_id
      @movimiento.recibido = true
      @documento = @movimiento.documento
      @area_destino = @movimiento.area_destino      
    end

    respond_to do |format|
      if @movimiento.save
        format.json{ render json: @movimiento}
      end
    end
  end

  def documentos_esperando    
    @items = @area.movimientos_esperando(texto_buscar: params[:texto_buscar], page: params[:page])
    respond_to do |format|
      format.json{ render json: @items.to_json(:include => [:documento]) }
    end
  end

  def documentos_recibir
    @items = @area.movimientos_recibir(texto_buscar: params[:texto_buscar], page: params[:page])
    respond_to do |format|
      format.json{ render json: @items.to_json }
    end
  end

  def documentos_enviados
    @items = @area.movimientos_enviados(texto_buscar: params[:texto_buscar], page: params[:page])
    respond_to do |format|
      format.json{ render json: @items.to_json(:include => [:documento]) }
    end
  end

  def documentos_recibidos    
    @items = @area.movimientos_recibidos(texto_buscar: params[:texto_buscar], page: params[:page])
    respond_to do |format|
      format.json{ render json: @items.to_json }
    end
  end

  def documentos_todos
    @items = @area.movimientos_fuente_destino(texto_buscar: params[:texto_buscar], page: params[:page])
    respond_to do |format|
      format.json{ 
        render json: @items.to_json
      }

    end
  end

  def cambiar_estado_documento
    @documento = Documento.find(documento_params[:documento_id])
    @documento.estado = documento_params[:estado].descendente
    
    respond_to do |format|
      if @documento.save
        format.json{ render json: @documento}
      end
    end
  end

  private
    def set_area
    	@area = Area.find(params[:id])
    end

    def documento_params      
      params.permit(:documento_id, :estado)
    end

end
