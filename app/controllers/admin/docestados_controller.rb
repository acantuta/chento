class Admin::DocestadosController < ApplicationController
  before_action :set_admin_docestado, only: [:show, :edit, :update, :destroy]

  # GET /admin/docestados
  # GET /admin/docestados.json
  def index
    @admin_docestados = Docestado.all
  end

  # GET /admin/docestados/1
  # GET /admin/docestados/1.json
  def show
  end

  # GET /admin/docestados/new
  def new
    @admin_docestado = Docestado.new
  end

  # GET /admin/docestados/1/edit
  def edit
  end

  # POST /admin/docestados
  # POST /admin/docestados.json
  def create
    @admin_docestado = Docestado.new(admin_docestado_params)

    respond_to do |format|
      if @admin_docestado.save
        format.html { redirect_to admin_docestados_url, notice: 'Docestado was successfully created.' }
        format.json { render :show, status: :created, location: @admin_docestado }
      else
        format.html { render :new }
        format.json { render json: @admin_docestado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/docestados/1
  # PATCH/PUT /admin/docestados/1.json
  def update
    respond_to do |format|
      if @admin_docestado.update(admin_docestado_params)
        format.html { redirect_to admin_docestados_url, notice: 'Docestado was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_docestado }
      else
        format.html { render :edit }
        format.json { render json: @admin_docestado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/docestados/1
  # DELETE /admin/docestados/1.json
  def destroy
    @admin_docestado.destroy
    respond_to do |format|
      format.html { redirect_to admin_docestados_url, notice: 'Docestado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_docestado
      @admin_docestado = Docestado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_docestado_params
      params.require(:docestado).permit(:nombre)
    end
end
