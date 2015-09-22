require 'bundler'
Bundler.require

json_file_path = 'settings.json'

json_data = open(json_file_path) do |io|
  JSON.load(io)
end

Host = json_data['osc']['host']
Port = json_data['osc']['port']
c = OSC::UDPSocket.new

available_pins = json_data['arduino']['available_pins']

messages = []
ArduinoFirmata.connect do
  available_pins['digital'].each do |pin|
    messages << OSC::Message.new("/digital/pin#{pin}", digital_read(pin))
  end
  available_pins['analog'].each do |pin|
    messages << OSC::Message.new("/analog/pin#{pin}", analog_read(pin))
  end
end

bundle = OSC::Bundle.new(nil, *messages)

c.send(bundle)
