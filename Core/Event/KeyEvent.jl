@eval Event begin

    struct KeyEventData <: EventData
        type::Event.EventType
        code::Cint
        repeat::Cint
        category::Event.EventCategory
    
        KeyEventData(type::Event.EventType, code::Cint, repeat::Cint) = new(type, code, repeat, (Event.S_KEYBOARD | Event.S_INPUT)::Event.EventCategory)
    end

end
