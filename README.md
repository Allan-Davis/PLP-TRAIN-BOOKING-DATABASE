# PLP-TRAIN-BOOKING-DATABASE

Train Booking System Relationships Explanation



Stations → Routes


Each route requires exactly two stations (origin and destination)
Example: Central Station NY, and Union Station, Chicago create a route
Routes have set base prices based on the station pairs


Routes + Trains → Schedules


Each route gets paired with available trains to create schedules
Example: The High-Speed Eagle Express is assigned to specific routes
Schedules represent one train journey on one specific date
Multiple schedules can exist for the same route with different trains


Schedules → Bookings → Passengers


Passengers book specific scheduled journeys
A booking links a passenger to one scheduled train journey
Each booking records status and total payment
Multiple bookings can exist for the same schedule


Bookings → Seats


Bookings connect to specific seat assignments
Seats have distinct classes: First/Business/Economy
Each seat class has its own pricing structure
Seat availability is tracked per booking

Flow Example

Route (Central Station → Union Station, 8 AM departure)


Train (300-seat high-speed service)


= Schedule (specific date's journey)
→ Booking (passenger reservation)
→ Seat (specific class and number)
