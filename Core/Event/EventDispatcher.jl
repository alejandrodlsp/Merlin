module EventDispatcher

import Event

function DispatchEvent(eventData::Event.EventData, eventType::Event.EventType, fnc)
    eventData.type == eventType && fnc(eventData)
end

function DispatchEventCategory(e::Event.EventData, c::Event.EventCategory, fnc)
    e.category | c && fnc(e)
end

# module
end