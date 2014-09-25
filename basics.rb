require 'sinatra'
require 'geocoder'
require 'timezone'

t = Time.now()

get '/' do

	"hello world!"
	
end

get '/about' do

	"there is something"

end

get '/hello/:name' do

	name_from_url = params[:name]
	"hello how are you, #{name_from_url.downcase}?"

end

get '/form' do 

	erb:form

end

Timezone::Configure.begin do |c| 
  c.username = 'kc_95' 


end

post '/form' do
  
  city = params[:message]
  timezones = Timezone::Zone.names
  find_zone = timezones.find{|e| /#{city}/ =~ e}
  timezone = Timezone::Zone.new :zone => find_zone
  show_time = timezone.time Time.now
  show_time = show_time.to_s.split(' ')
  time = show_time[1]
  time = time.split(':')
  hours = time[0]
  minutes = time[1]

  if hours.to_i > 12
  	hours = hours.to_i - 12
  	meridiem = "p.m."

  else
  	meridiem = "a.m."

  end

  "<center><h3>the current time in #{city} is:</h3><br><br><h1>#{hours}:#{minutes} #{meridiem}</h1></center>"

 
end
