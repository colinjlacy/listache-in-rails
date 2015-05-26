class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:show, :edit, :update, :destroy, :add_item, :delete_item, :send_form, :send_list]
  before_action :confirm_owner, only: [:show, :edit, :update, :destroy, :add_item, :delete_item, :send_form, :send_list]

  # GET /lists
  # GET /lists.json
  def index
	  @list = List.new(user_id: current_user)
	  @lists = List.where user_id: current_user.id
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)
	@list.user_id = current_user.id
    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /lists/1/add
  def add_item
	  respond_to do |format|
		  item = params[:item]
		  @list.list_items = @list.list_items ? @list.list_items.push(item) : [item]
		  if @list.save
			  format.html { render :edit, notice: (item + ' - successfully added!') }
			  format.json { render :show, status: :ok, location: @list }
		  else
			  format.html { render :edit }
			  format.json { render json: @list.errors, status: :unprocessable_entity }
		  end
	  end
  end

  # DELETE /lists/1/bananas
  def delete_item
	  respond_to do |format|
		  item = params[:item]
		  @list.list_items.delete item
		  if @list.save
			  format.html { render :edit, notice: (item + ' - successfully removed!') }
			  format.json { render :show, status: :ok, location: @list }
		  else
			  format.html { render :edit }
			  format.json { render json: @list.errors, status: :unprocessable_entity }
		  end
	  end
  end

  def unauthorized
  end

  def send_form
  end

  def send_list
	  to_email = params['to_email']
	  message = params['message']
	  ListMailer.send(@list, current_user.email, to_email, message)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params[:list].permit(:title)
	end

  	# confirm the current user actually has access
	def confirm_owner
		render :unauthorized if current_user.id != @list.user_id
	end
end
