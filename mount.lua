function unmount()
    for disk,properties in pairs(hs.fs.volume.allVolumes(true)) do
      if(properties.NSURLVolumeIsEjectableKey) then
        success = hs.fs.volume.eject(disk)
        if(success) then
          print("Ejected "..disk)
        end
        if(not success) then
          hs.alert.show("Could not eject "..disk)
        end
      end
    end
end

hs.hotkey.bind(hyper, "k", function() unmount() end)
