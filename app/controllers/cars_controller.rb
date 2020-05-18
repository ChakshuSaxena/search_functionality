class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
    respond_to do |format|
      format.html
      format.csv { send_data @cars.to_csv, disposition: :inline }
    end

  end

  def import
    @cars = Car.all
    @import = Car::Import.new car_import_params
    if @import.save

      redirect_to cars_path, notice: "Imported #{@import.imported_count} cars"
    else 

      @users = Car.all
      flash[:alert] = "there were #{@import.imported_count} errors with your CSV file"
      render action: :index
    end 
  end

  def scrape
    debugger
    @cars = Car.all
    url = 'https://www.autoscout24.com/lst?sort=price&desc=0&offer=N&fuel=2%2C3%2CE&ustate=N%2CU&size=20&page=1&atype=C&'
    response = CarsSpider.process(url)
    if response[:status] == :completed && response[:error].nil?
      puts "hello welcome the world of web scrapping"
      flash.now[:notice] = "Successfully scraped url"
    else
      flash.now[:alert] = response[:error]
    end
    rescue StandardError => e
      flash.now[:alert] = "Error: #{e}"
  end

  def scrape2
    debugger
    @cars = {}
    @cars = Car.all
    url = "https://www.autoscout24.com/offers/kia-niro-ev-high-spirit-leder-glasdach-electric-black-dee85dec-8b87-4f27-9724-701330c4e26a?cldtidx=1&cldtsrc=listPage"
    debugger
    response1 = CarsSpider.process(url)
    debugger
    if response1[:status] == :completed && response1[:error].nil?
      debugger
      puts "hello welcome the world of web scrapping"
      flash.now[:notice] = "Successfully scraped url"
    else
      debugger
      flash.now[:alert] = response1[:error]
    end
    rescue StandardError => e
      flash.now[:alert] = "Error: #{e}"
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    @cars = Car.all
    respond_to do |format|
      format.html
      format.csv { send_data @cars.to_csv, disposition: :inline }
    end
  end

  # GET /cars/new
  def new
    @cars = Car.all
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @cars = Car.all
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    @cars = Car.all
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @cars = Car.all
    @car.destroy
    respond_to do |format|
      format.html { redirect_to scrape_cars_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.last
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:title, :stock_type, :exterior_color, :interior_color, :transmission, :drivetrain, :price, :miles)
    end


    def user_import_params
      params.require(:car_import).permit(:file)
    end
end
