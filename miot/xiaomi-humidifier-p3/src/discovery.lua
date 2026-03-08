local log = require "log"

local discovery = {}

-- 장치 생성
function discovery.create_device(driver)
    local success, err = pcall(function()
        driver:try_create_device({
            type = "LAN",
            device_network_id = "miot-humidifier-p3-" .. os.time(),
            label = "Xiaomi Humidifier P3",
            profile = "xiaomi-humidifier-p3",
            manufacturer = "Xiaomi",
            model = "xiaomi.humidifier.p3",
            vendor_provided_label = "MIJIA Mist-Free Humidifier 3 (400)",
        })
    end)

    if not success then
        log.error("장치 생성 실패: " .. tostring(err))
    end

    return success
end

-- 장치 검색 핸들러
function discovery.handle_discovery(driver, opts, cont)
    if #driver:get_devices() == 0 then
        discovery.create_device(driver)
    end
end

return discovery
