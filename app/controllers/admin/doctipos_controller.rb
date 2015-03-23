class Admin::DoctiposController < ApplicationController
  before_action :set_admin_doctipo, only: [:show, :edit, :update, :destroy]

  # GET /admin/doctipos
  # GET /admin/doctipos.json
  def index
    @admin_doctipos = Doctipo.all
  end

  # GET /admin/doctipos/1
  # GET /admin/doctipos/1.json
  def show
  end

  # GET /admin/doctipos/new
  def new
    @admin_doctipo = Doctipo.new
  end

  # GET /admin/doctipos/1/edit
  def edit
  end

  # POST /admin/doctipos
  # POST /admin/doctipos.json
  def create
    @admin_doctipo = Doctipo.new(admin_doctipo_params)

    respond_to do |format|
      if @admin_doctipo.save
        format.html { redirect_to controller: :doctipos, notice: 'Doctipo was successfully created.' }
        format.json { render :show, status: :created, location: @admin_doctipo }
      else
        format.html { render :new }
        format.json { render json: @admin_doctipo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/doctipos/1
  # PATCH/PUT /admin/doctipos/1.json
  def update
    respond_to do |format|
      if @admin_doctipo.update(admin_doctipo_params)
        format.html { redirect_to controller: :doctipos, notice: 'Doctipo was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_doctipo }
      else
        format.html { render :edit }
        format.json { render json: @admin_doctipo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/doctipos/1
  # DELETE /admin/doctipos/1.json
  def destroy
    @admin_doctipo.destroy
    respond_to do |format|
      format.html { redirect_to admin_doctipos_url, notice: 'Doctipo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_doctipo
      @admin_doctipo = Doctipo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_doctipo_params
      params.require(:doctipo).permit(:nombre)
    end
end
