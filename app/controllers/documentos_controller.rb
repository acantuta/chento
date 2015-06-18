class DocumentosController < ApplicationController
  before_action :authenticate_user!, exept: [:show]
  before_action :set_documento, only: [:show, :edit, :update, :destroy, :cambiar_estado]

  # GET /documentos
  # GET /documentos.json
  def index
    @documentos = Documento.all
  end

  # GET /documentos/1
  # GET /documentos/1.json
  def show
  end

  # GET /documentos/new
  def new
    @documento = Documento.new(new_documento_params)
    if params[:documento_hijo_id]
      @documento_hijo = Documento.find(params[:documento_hijo_id])
    end

    if params[:area_generadora_id]
      @area_generadora = Area.find(params[:area_generadora_id])
      @documento.cod_remitente = @area_generadora.jefes.first.username
      @documento.remitente = @area_generadora.jefes.first.fullname
    end
  end

  # GET /documentos/1/edit
  def edit
  end

  # POST /documentos
  # POST /documentos.json
  def create
    ActiveRecord::Base.transaction do
      @documento = Documento.new(documento_params)
      @documento.user = current_user
      @movimiento = Docmovimiento.new(docmovimiento_params)
      @movimiento.area_fuente_id = @documento.area_generadora_id
      @movimiento.documento = @documento    
      if params[:documento_hijo_id]
        @documento_hijo = Documento.find(params[:documento_hijo_id])
      end
      respond_to do |format|
        if @documento.save
          Doclog.create(documento_id: @documento.id, contenido: "Se ha registrado documento.")

          #Graba referencias el documento
          if new_documento_hijo_params[:documento_hijo_id]
            doc_hijo_id = new_documento_hijo_params[:documento_hijo_id]

            #Obteniendo las referencias del documento hijo.            
            refs_hijo = Docreferencia.where(documento_padre_id: doc_hijo_id).all

            #Inserta las referencias del documento hijo.
            refs_hijo.each do |ref|              
              Docreferencia.create!(documento_padre_id: @documento.id, documento_hijo_id: ref.documento_hijo_id)
            end

            Docreferencia.create!(documento_padre_id: @documento.id, documento_hijo_id: doc_hijo_id)
          end
          @movimiento.save!
          

          format.html { redirect_to areas_base_path(@documento.area_generadora_id), notice: 'Documento creado exitosamente.' }
          format.json { render :show, status: :created, location: @documento }
        else
          format.html { render :new }
          format.json { render json: @documento.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /documentos/1
  # PATCH/PUT /documentos/1.json
  def update
    respond_to do |format|
      if @documento.update(documento_params)
        format.html { redirect_to @documento, notice: 'Documento was successfully updated.' }
        format.json { render :show, status: :ok, location: @documento }
      else
        format.html { render :edit }
        format.json { render json: @documento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentos/1
  # DELETE /documentos/1.json
  def destroy
    @documento.destroy
    respond_to do |format|
      format.html { redirect_to documentos_url, notice: 'Documento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def cambiar_estado
    @documento.estado = documento_cambiar_estado_params['estado']
    @documento.save!
    respond_to do |format|
      format.json{
        render json: @documento
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_documento
      @documento = Documento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def documento_params      
      params.require(:documento).permit(:doctipo_id, :docestado_id, :nro, :folios, :asunto, :remitente, :cod_remitente, :ambiente,:area_generadora_id, :estado)
    end

    def docmovimiento_params
      params.require(:docmovimiento).permit(:area_destino_id, :movaccion_id)
    end

    def new_documento_params
      params.require(:area_generadora_id)
      params.permit(:area_generadora_id)
    end

    def new_documento_hijo_params
      params.permit(:documento_hijo_id)
    end

    def documento_cambiar_estado_params
      params.require(:estado)
      params.permit(:estado)
    end
end

