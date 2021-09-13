push!(LOAD_PATH, pwd() * "/Core")
push!(LOAD_PATH, pwd() * "/Core/Event")

import Pkg
Pkg.precompile()

include("Core/Application.jl")