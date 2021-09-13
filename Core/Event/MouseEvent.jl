@eval Event begin

    using Base:Float64

    export MouseMovedEventData, MouseButtonEventData, MouseScrollEventData

    struct MouseMovedEventData <: EventData
        type
        posx::Float64
        posy::Float64
        category

        MouseMovedEventData(posx, posy) = new(EventTypeMouseMoved, posx, posy, (S_MOUSE | S_INPUT)::EventCategory)
    end

    struct MouseButtonEventData <: EventData
        type 
        code::UInt16
        category

        MouseButtonEventData(type, code) = new(type, code, (S_MOUSE | S_INPUT)::EventCategory)
    end

    struct MouseScrollEventData <: EventData
        type
        scrollX::Float64
        scrollY::Float64
        category

        MouseScrollEventData(scrollX, scrollY) = new(EventTypeMouseScrolled, scrollX, scrollY, (S_MOUSE | S_INPUT)::EventCategory)
    end

# module
end