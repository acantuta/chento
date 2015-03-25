class DocumentosController < ApplicationController
  before_action :authenticate_user!, exept: [:show]
  before_action :set_documento, only: [:show, :edit, :update, :destroy]

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
      respond_to do |format|
        if @documento.save
          @movimiento.save!
          format.html { redirect_to areas_base_path(@documento.area_generadora_id), notice: 'Documento was successfully created.' }
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
end

