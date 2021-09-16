@eval Event begin

    struct WindowCloseEvent <: EventData
        type::Event.EventType
        category::Event.EventCategory
  
        WindowCloseEvent() = new(Event.EventTypeWindowClose, (Event.S_WINDOW)::Event.EventCategory)
    end

    struct WindowSizeEvent <: EventData
        type::Event.EventType
        sizex::Cint
        sizey::Cint
        category::Event.EventCategory

        WindowSizeEvent(sizex::Cint, sizey::Cint) = new(Event.EventTypeWindowResize, sizex, sizey, (Event.S_WINDOW)::Event.EventCategory)
    end

    struct WindowMovedEvent <: EventData
        type::Event.EventType
        posx::Cint
        posy::Cint
        category::Event.EventCategory

        WindowMovedEvent(posx::Cint, posy::Cint) = new(Event.EventTypeWindowMoved, posx, posy, (Event.S_WINDOW)::Event.EventCategory)
    end

end
