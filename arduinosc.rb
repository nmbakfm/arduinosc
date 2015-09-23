require 'bundler'
Bundler.require

json_file_path = File.expand_path('./setting.json')
json_data = open(json_file_path) do |io|
  JSON.load(io)
end

Host = json_data['osc']['host']
Port = json_data['osc']['port']
c = OSC::Client.new(Host, Port)

arduino_settings = json_data['arduino']
available_pins = arduino_settings['available_pins']

arduino = ArduinoFirmata.connect arduino_settings['modem']
puts "firmata version #{arduino.version}"

available_pins['digital'].each do |pin|
  arduino.pin_mode pin, ArduinoFirmata::OUTPUT
end

loop do
  messages = []

  available_pins['digital'].each do |pin|
    messages << OSC::Message.new(
      "/digital/pin#{pin}",
      arduino.digital_read(pin) ? 1 : 0
    )
    print((arduino.digital_read(pin) ? 1 : 0).to_s + ' ')
  end
  puts "\n"
  available_pins['analog'].each do |pin|
    messages << OSC::Message.new(
      "/analog/pin#{pin}",
      arduino.analog_read(pin)
    )
    print(arduino.analog_read(pin).to_s + ' ')
  end
  puts "\n"
  puts "\n"

  bundle = OSC::Bundle.new(nil, *messages)
  c.send(bundle)
  sleep(0.05)
end
