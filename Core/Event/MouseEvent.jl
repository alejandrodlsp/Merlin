@eval Event begin

    using Base:Float64

    export MouseMovedEventData, MouseButtonEventData, MouseScrollEventData

    struct MouseMovedEventData <: EventData
        type::Event.EventType
        posx::Float64
        posy::Float64
        category::Event.EventCategory

        MouseMovedEventData(posx::Float64, posy::Float64) = new(EventTypeMouseMoved, posx, posy, (S_MOUSE | S_INPUT)::EventCategory)
    end

    struct MouseButtonEventData <: EventData
        type::Event.EventType
        code::Cint
        category::Event.EventCategory

        MouseButtonEventData(type::Event.EventType, code::Cint) = new(type, code, (S_MOUSE | S_INPUT)::EventCategory)
    end

    struct MouseScrollEventData <: EventData
        type::Event.EventType
        scrollX::Float64
        scrollY::Float64
        category::Event.EventCategory

        MouseScrollEventData(scrollX::Float64, scrollY::Float64) = new(EventTypeMouseScrolled, scrollX, scrollY, (S_MOUSE | S_INPUT)::EventCategory)
    end

# module
end