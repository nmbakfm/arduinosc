require 'json'
require 'rosc'
require 'arduino_firmata'

json_file_path = "settings"

json_data = open(json_file_path) do |io|
  JSON.load(io)
end

File.open "setting.json"

Host = json_data["host"]
Port = json_data["port"]
c = OSC::UDPSocket.new

value = "aaa"

m = OSC::Message.new("/arduinosc", "s", value)

c.send(m, 0, Host, Port)
