json.extract! car, :id, :title, :stock_type, :exterior_color, :interior_color, :transmission, :drivetrain, :price, :miles, :created_at, :updated_at
json.url car_url(car, format: :json)
