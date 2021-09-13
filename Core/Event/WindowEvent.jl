@eval Event begin

    struct WindowCloseEvent <: EventData
        type
        category
  
        WindowCloseEvent() = new(Event.EventTypeWindowClose, (Event.S_WINDOW)::Event.EventCategory)
    end

    struct WindowSizeEvent <: EventData
        type
        sizex::Int32
        sizey::Int32
        category

        WindowSizeEvent(sizex::Int32, sizey::Int32) = new(Event.EventTypeWindowResize, sizex, sizey, (Event.S_WINDOW)::Event.EventCategory)
    end

    struct WindowMovedEvent <: EventData
        type
        posx::Int32
        posy::Int32
        category

        WindowMovedEvent(posx::Int32, posy::Int32) = new(Event.EventTypeWindowMoved, posx, posy, (Event.S_WINDOW)::Event.EventCategory)
    end

end
