class PeopleController < ApplicationController
  before_action :authenticate_person!
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    query = if params[:q]
      { query_string: { query: params[:q] } }
    else
      { match_all: {} }
    end

    sort = if params[:q]
      {}
    else
      "name.raw"
    end

    @response = Person.search \
                 query: {
                   filtered: {
                     query: query,
                     filter: { term: { account_id: @account.id } }
                   }
                 },
                 aggs: {
                   roles: {
                    nested: {
                      path: "roles"
                    },
                    aggs: {
                      count: {
                        terms: {
                          field: "roles.name"
                        }
                      }
                    }
                   }
                 },
                 sort: sort,
                 size: 25

    @people = @response.records.includes(:roles) #@account.people.order(:name).limit(100).includes(:roles)
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = @account.people.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    respond_to do |format|
      if @person == current_person
        format.html { redirect_to people_url, alert: 'You cannot destroy yourself.' }
        format.json { head :conflict }
      else
        @person.destroy
        format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = @account.people.includes(:roles).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :gender, :phone, :email, :date_of_birth, {:role_ids => []})
    end
end
