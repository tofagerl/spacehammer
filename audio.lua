audioArray = {}
audioArray["Speaker"] = "Impresario"
audioArray["Astro A50 Game"] = "Astro A50"
audioArray["Built-in Output"] = "Internal Speaker"
audioArray["MacBook Pro Speakers"] = "Internal Speaker"
audioArray["FiiO USB DAC-E10"] = "FiiO"
audioArray["Logitech G930 Headset"] = "G930"
audioArray["Tom’s AirPods Pro"] = "Airpods"
-- audioArray["DisplayPort"] = "Jobbskjerm"
current = hs.audiodevice.defaultOutputDevice()
function switch_audio()
  for _,device in pairs(hs.audiodevice.allOutputDevices()) do
    if device and device ~= current and audioArray[device:name()] then
      hs.alert.show(audioArray[device:name()])
      current = device
      device:setDefaultOutputDevice()
      break
    end
  end
end
hs.hotkey.bind(hyper, "a", function() switch_audio() end)

-- Avoid automatically setting a bluetooth audio input device

lastSetDeviceTime = os.time()
lastInputDevice = nil

function audioDeviceChanged(arg)
  if arg == 'dev#' then
    lastSetDeviceTime = os.time()
    elseif arg == 'dIn ' and os.time() - lastSetDeviceTime < 2 then
      inputDevice = hs.audiodevice.defaultInputDevice()
      if inputDevice:transportType() == 'Bluetooth' then
        internalMic = lastInputDevice or hs.audiodevice.findInputByName('Built-in Microphone')
        internalMic:setDefaultInputDevice()
      end
    end
    if hs.audiodevice.defaultInputDevice():transportType() ~= 'Bluetooth' then
      lastInputDevice = hs.audiodevice.defaultInputDevice()
    end
  end

  hs.audiodevice.watcher.setCallback(audioDeviceChanged)
  hs.audiodevice.watcher.start()
