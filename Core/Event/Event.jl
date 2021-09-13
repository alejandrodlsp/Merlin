module Event

using Base:UInt32
using BitFlags

export EventType, EventCategory, EventData, RegisterListener

@enum EventType begin
    EventTypeNone
    EventTypeKeyPressed 
    EventTypeKeyReleased
    EventTypeMouseButtonPressed
    EventTypeMouseButtonReleased
    EventTypeMouseMoved
    EventTypeMouseScrolled
    EventTypeWindowClose
    EventTypeWindowResize
    EventTypeWindowFocus
    EventTypeWindowLostFocus
    EventTypeWindowMoved
    EventTypeAppTick
    EventTypeAppUpdate
    EventTypeAppRender
end

@BitFlags.bitflag EventCategory::UInt8 S_NONE = 0 S_INPUT S_WINDOW S_KEYBOARD S_MOUSE S_APPICATION

abstract type EventData end

include("KeyEvent.jl")
include("MouseEvent.jl")
include("WindowEvent.jl")

# List of event listeners
mListeners = Array{Function}(undef, 0)

# Register a new Event Listener
function RegisterListener(e::Function)
  append!(mListeners, [e])
end

function Dispatch(e)
  for l::Function in mListeners
      l(e)
  end
end
  
# module
end    