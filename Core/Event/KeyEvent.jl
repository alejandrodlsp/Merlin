@eval Event begin

    struct KeyEventData <: EventData
        type
        code::UInt16
        repeat::UInt32
        category
    
        KeyEventData(type, code, repeat) = new(type, code, repeat, (Event.S_KEYBOARD | Event.S_INPUT)::Event.EventCategory)
    end

end
