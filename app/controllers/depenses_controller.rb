class DepensesController < ApplicationController
  before_action :set_depense, only: %i[ show edit update destroy ]
  before_action :user_authorized?, only: %i[show edit update destroy ]

  # GET /depenses or /depenses.json
  def index
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @depenses = Depense.where(user: current_user).where(date: start_date..end_date)
    else
      current_date = Date.current
      if current_date.day < current_user.monthly_debit_date
        # Display expenses from the previous month
        starting_date = (current_date.beginning_of_month - 1.month) + (current_user.monthly_debit_date - 1).days
      else
        # Display expenses from the current month
        starting_date = current_date.beginning_of_month + (current_user.monthly_debit_date - 1).days
      end

      @depenses = Depense.where(user: current_user).where("date >= ?", starting_date)
    end
  end

  # GET /depenses/1 or /depenses/1.json
  def show
  end

  # GET /depenses/new
  def new
    if Category.where(user: current_user).empty?
      redirect_to depenses_path, alert: "Vous devez d'abord créer au moins une catégorie"
    end
    @depense = Depense.new
  end

  # GET /depenses/1/edit
  def edit
  end

  # POST /depenses or /depenses.json
  def create
    @depense = Depense.new(depense_params)

    respond_to do |format|
      if @depense.save
        format.html { redirect_to depense_url(@depense), notice: "Depense was successfully created." }
        format.json { render :show, status: :created, location: @depense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @depense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /depenses/1 or /depenses/1.json
  def update
    respond_to do |format|
      if @depense.update(depense_params)
        format.html { redirect_to depense_url(@depense), notice: "Depense was successfully updated." }
        format.json { render :show, status: :ok, location: @depense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @depense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /depenses/1 or /depenses/1.json
  def destroy
    @depense.destroy

    respond_to do |format|
      format.html { redirect_to depenses_url, notice: "Depense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_depense
      @depense = Depense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def depense_params
      params.require(:depense).permit(:date, :user_id, :category_id, :amount)
    end

    def user_authorized?
      if @depense.user != current_user
        redirect_to depenses_path, notice: "Vous n'êtes pas autorisé à voir cette page"
      end
    end
end
