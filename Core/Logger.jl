module Logger

using Logging

export Init, Shutdown

logger = missing
io = missing

macro assert(ex)
    return :( $ex ? nothing : throw(AssertionError($(string(ex)))) )
end

function Init()
    if haskey(ENV, "MERLIN_ENVIRONMENT") && ENV["MERLIN_ENVIRONMENT"] != "DEBUG" 
        Logging.disable_logging(Logging.Error) # Disable warn, debug and info
        global logger = NullLogger()
        global_logger(logger)
        return
    end

    ENV["JULIA_DEBUG"] = Main

    if haskey(ENV, "MERLIN_LOG_PATH")
        global io = open(ENV["MERLIN_LOG_PATH"], "w+")
        global logger = SimpleLogger(io)
    else
        global logger = ConsoleLogger()
    end

    global_logger(logger)
end

function Shutdown()
  !ismissing(io) ? flush(io) : ()
end

# module
end