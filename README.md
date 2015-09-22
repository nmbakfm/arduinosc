# ArduinOSC

convert Arduino signals to OSC(Open Sound Control)

# Usage

this App need Firmata Library on Arduino

You should install ruby v2.2.3 and bundler.

```plain
cd your/app/path
git clone git@github.com:nmbakfm/arduinosc.git
cd arduinosc
bundler install --path=vendor/bundle
```

# Execute
```plain
ruby arduinosc.rb
```

# Settings

write your settings on setting.json. like following code: 

```json
{
  "osc":{
    "host": "localhost",
    "port": "3333"
  },
  "arduino":{
    "modem": "/dev/tty.usbmodem621",
    "available_pins":{
      "analog": [0,1,2,3],
      "digital": [13,12,11,10]
    }
  }
}
```
